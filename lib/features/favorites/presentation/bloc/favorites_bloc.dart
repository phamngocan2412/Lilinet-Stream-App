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

  static const int _limit = 20;

  FavoritesBloc({
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.getFavoritesUseCase,
  }) : super(const FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<LoadMoreFavorites>(_onLoadMoreFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<ClearFavorites>(_onClearFavorites);
  }

  @override
  Future<void> close() {
    // Ensure all resources are disposed
    return super.close();
  }

  void _onClearFavorites(ClearFavorites event, Emitter<FavoritesState> emit) {
    emit(const FavoritesInitial());
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    if (event.page == 1) {
      emit(const FavoritesLoading());
    }

    final result = await getFavoritesUseCase(page: event.page, limit: _limit);
    result.fold(
      (failure) => emit(FavoritesError(message: failure.message)),
      (favorites) => emit(
        FavoritesLoaded(
          favorites: favorites,
          currentPage: event.page,
          hasMore: favorites.length >= _limit,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreFavorites(
    LoadMoreFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FavoritesLoaded) return;
    if (!currentState.hasMore) return;

    final nextPage = currentState.currentPage + 1;

    final result = await getFavoritesUseCase(page: nextPage, limit: _limit);

    result.fold((failure) => emit(FavoritesError(message: failure.message)), (
      newFavorites,
    ) {
      emit(
        currentState.copyWith(
          favorites: [...currentState.favorites, ...newFavorites],
          currentPage: nextPage,
          hasMore: newFavorites.length >= _limit,
        ),
      );
    });
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    List<Favorite> currentFavorites = [];
    int currentPage = 1;
    bool hasMore = true;

    if (currentState is FavoritesLoaded) {
      currentFavorites = List.from(currentState.favorites);
      currentPage = currentState.currentPage;
      hasMore = currentState.hasMore;
    }

    final result = await addFavoriteUseCase(
      movieId: event.movieId,
      movieTitle: event.movieTitle,
      moviePoster: event.moviePoster,
      movieType: event.movieType,
      folder: event.folder,
    );

    result.fold((failure) => emit(FavoritesError(message: failure.message)), (
      favorite,
    ) {
      // Optimistic update: Add to list immediately without reloading
      currentFavorites.insert(0, favorite); // Add to top
      emit(
        FavoritesLoaded(
          favorites: currentFavorites,
          currentPage: currentPage,
          hasMore: hasMore,
        ),
      );
    });
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    List<Favorite> currentFavorites = [];
    int currentPage = 1;
    bool hasMore = true;

    if (currentState is FavoritesLoaded) {
      currentFavorites = List.from(currentState.favorites);
      currentPage = currentState.currentPage;
      hasMore = currentState.hasMore;
    }

    final result = await removeFavoriteUseCase(event.movieId);

    result.fold((failure) => emit(FavoritesError(message: failure.message)), (
      _,
    ) {
      // Optimistic update: Remove from list immediately without reloading
      currentFavorites.removeWhere((f) => f.movieId == event.movieId);
      emit(
        FavoritesLoaded(
          favorites: currentFavorites,
          currentPage: currentPage,
          hasMore: hasMore,
        ),
      );
    });
  }
}
