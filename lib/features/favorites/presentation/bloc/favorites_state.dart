import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/favorite.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = FavoritesInitial;

  const factory FavoritesState.loading() = FavoritesLoading;

  const factory FavoritesState.loaded({
    required List<Favorite> favorites,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
  }) = FavoritesLoaded;

  const factory FavoritesState.error({required String message}) =
      FavoritesError;
}

extension FavoritesLoadedX on FavoritesLoaded {
  bool isFavorite(String movieId) {
    return favorites.any((f) => f.movieId == movieId);
  }
}
