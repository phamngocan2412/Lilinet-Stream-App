import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/anime_detection_service.dart';
import '../../../domain/repositories/movie_repository.dart';
import '../../../domain/usecases/get_movie_details.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/entities/episode.dart';
import '../../../../settings/domain/repositories/settings_repository.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

@injectable
class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetails _getMovieDetails;
  final MovieRepository _repository;
  final SettingsRepository _settingsRepository;
  final AnimeDetectionService _animeDetectionService;

  MovieDetailsBloc(
    this._getMovieDetails,
    this._repository,
    this._settingsRepository,
    this._animeDetectionService,
  ) : super(MovieDetailsInitial()) {
    on<LoadMovieDetails>(_onLoadMovieDetails);
    on<SetMovieDetails>(_onSetMovieDetails);
    on<SelectSeason>(_onSelectSeason);
  }

  void _onSetMovieDetails(
    SetMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) {
    final movie = event.movie;
    final initialSeason = _determineInitialSeason(movie);
    final episodes = _filterEpisodes(movie, initialSeason);

    emit(
      MovieDetailsLoaded(
        movie,
        selectedSeason: initialSeason,
        filteredEpisodes: episodes,
      ),
    );
  }

  void _onSelectSeason(SelectSeason event, Emitter<MovieDetailsState> emit) {
    if (state is MovieDetailsLoaded) {
      final currentState = state as MovieDetailsLoaded;
      final episodes = _filterEpisodes(currentState.movie, event.seasonNumber);
      emit(
        currentState.copyWith(
          selectedSeason: event.seasonNumber,
          filteredEpisodes: episodes,
        ),
      );
    }
  }

  Future<void> _onLoadMovieDetails(
    LoadMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    // 1. Try to load cached data first (INSTANT)
    final cachedMovie = _repository.getCachedMovieDetails(event.id);
    if (cachedMovie != null) {
      final initialSeason = _determineInitialSeason(cachedMovie);
      final episodes = _filterEpisodes(cachedMovie, initialSeason);
      emit(
        MovieDetailsLoaded(
          cachedMovie,
          selectedSeason: initialSeason,
          filteredEpisodes: episodes,
        ),
      );
    } else {
      emit(MovieDetailsLoading());
    }

    // 2. Fetch FAST metadata (Title, Poster, etc.) - SKIPS provider scraping
    // This allows the user to see the page content almost instantly.
    // Note: This result might not have episodes if the provider is slow.
    final fastResult = await _getMovieDetails(
      GetMovieDetailsParams(
        id: event.id,
        type: event.type.toLowerCase(), // Ensure type is lowercase
        fastMode: true,
      ),
    );

    fastResult.fold(
      (failure) {
        if (cachedMovie == null) emit(MovieDetailsError(failure.message));
      },
      (movie) {
        // Only emit if we don't have better data yet (or if cache was empty)
        // If we emitted cache, this might update/refine metadata
        final initialSeason = _determineInitialSeason(movie);
        final episodes = _filterEpisodes(movie, initialSeason);
        emit(
          MovieDetailsLoaded(
            movie,
            selectedSeason: initialSeason,
            filteredEpisodes: episodes,
          ),
        );
      },
    );

    // 3. Fetch FULL data (Episodes) - INCLUDES provider scraping
    // Determine provider from settings
    String? provider;
    final settingsResult = await _settingsRepository.getSettings();
    settingsResult.fold(
      (l) => null, // Use default if settings fail
      (settings) {
        if (event.type.toLowerCase() == 'movie' ||
            event.type.toLowerCase().contains('tv')) {
          // Detect if content is anime using AnimeDetectionService
          bool isAnime = false;

          fastResult.fold(
            (failure) {
              if (kDebugMode) {
                debugPrint(
                  '⚠️ Fast fetch failed, cannot detect anime: ${failure.message}',
                );
              }
              // Fallback: If it's TV Series with Animation, likely anime
              if (event.type.toLowerCase().contains('tv')) {
                if (kDebugMode) {
                  debugPrint('   Defaulting to anime provider for TV Series');
                }
                isAnime = true;
              }
            },
            (movie) {
              isAnime = _animeDetectionService.isAnime(movie, event.type);

              if (kDebugMode) {
                if (isAnime) {
                  final reason = _animeDetectionService.getDetectionReason(
                    movie,
                    event.type,
                  );
                  debugPrint('✅ Detected anime content: ${movie.title}');
                  debugPrint('   Reason: $reason');
                } else {
                  debugPrint('ℹ️ Detected non-anime content: ${movie.title}');
                  debugPrint('   Genres: ${movie.genres.join(", ")}');
                }
              }
            },
          );

          // IMPORTANT: Always use anime provider for anime content
          // Movie providers (flixhq, goku, etc.) don't work with anime IDs
          if (isAnime) {
            provider = settings.animeProvider;
            if (kDebugMode) {
              debugPrint('📺 Using anime provider: $provider');
            }
          } else {
            provider = settings.movieProvider;
            if (kDebugMode) {
              debugPrint('🎬 Using movie provider: $provider');
            }
          }
        }
      },
    );

    final fullResult = await _getMovieDetails(
      GetMovieDetailsParams(
        id: event.id,
        type: event.type.toLowerCase(), // Ensure type is lowercase
        provider: provider,
        fastMode: false,
      ),
    );

    fullResult.fold(
      (failure) {
        // If fast mode succeeded but full failed, we technically still have data.
        // But the episodes might be missing/incomplete.
        // We can just silently fail or show error if we had nothing.
        if (state is! MovieDetailsLoaded) {
          emit(MovieDetailsError(failure.message));
        }
      },
      (movie) {
        final initialSeason = _determineInitialSeason(movie);
        final episodes = _filterEpisodes(movie, initialSeason);
        emit(
          MovieDetailsLoaded(
            movie,
            selectedSeason: initialSeason,
            filteredEpisodes: episodes,
          ),
        );
      },
    );
  }

  int _determineInitialSeason(Movie movie) {
    if (movie.episodes == null || movie.episodes!.isEmpty) return 1;
    // Find the lowest season number available
    // Or default to 1
    final seasons = movie.episodes!.map((e) => e.season ?? 1).toSet().toList();
    seasons.sort();
    return seasons.isNotEmpty ? seasons.first : 1;
  }

  List<Episode> _filterEpisodes(Movie movie, int season) {
    if (movie.episodes == null) return [];

    // If it's a Movie, return all episodes (usually just one)
    if (movie.type.toLowerCase() == 'movie') {
      return movie.episodes!;
    }

    // For TV Series, filter by season
    final filtered =
        movie.episodes!.where((e) => (e.season ?? 1) == season).where((e) {
      if (e.releaseDate != null && e.releaseDate!.isAfter(DateTime.now())) {
        return false;
      }
      return true;
    }).toList();

    // Sort episodes by number
    filtered.sort((a, b) => a.number.compareTo(b.number));

    return filtered;
  }
}
