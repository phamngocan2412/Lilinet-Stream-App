import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/usecases/add_favorite.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/remove_favorite.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

@injectable
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final AddFavorite addFavoriteUseCase;
  final RemoveFavorite removeFavoriteUseCase;
  final GetFavorites getFavoritesUseCase;

  FavoritesBloc({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getFavoritesUseCase,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  void _onClearFavorites(
    ClearFavorites event,
    Emitter<FavoritesState> emit,
  ) {
    emit(FavoritesInitial());
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    final result = await getFavoritesUseCase();
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites)),
    );
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    List<Favorite> currentFavorites = [];
    if (currentState is FavoritesLoaded) {
      currentFavorites = List.from(currentState.favorites);
    }

    final result = await addFavoriteUseCase(
      movieId: event.movieId,
      movieTitle: event.movieTitle,
      moviePoster: event.moviePoster,
      movieType: event.movieType,
    );

    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorite) {
        // Optimistic update: Add to list immediately without reloading
        currentFavorites.add(favorite);
        emit(FavoritesLoaded(currentFavorites));
      },
    );
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    List<Favorite> currentFavorites = [];
    if (currentState is FavoritesLoaded) {
      currentFavorites = List.from(currentState.favorites);
    }

    final result = await removeFavoriteUseCase(event.movieId);

    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (_) {
        // Optimistic update: Remove from list immediately without reloading
        currentFavorites.removeWhere((f) => f.movieId == event.movieId);
        emit(FavoritesLoaded(currentFavorites));
      },
    );
  }
}
