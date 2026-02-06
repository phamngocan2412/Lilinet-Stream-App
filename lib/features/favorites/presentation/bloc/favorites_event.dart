import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_event.freezed.dart';

@freezed
class FavoritesEvent with _$FavoritesEvent {
  const factory FavoritesEvent.loadFavorites({@Default(1) int page}) = LoadFavorites;

  const factory FavoritesEvent.loadMoreFavorites() = LoadMoreFavorites;

  const factory FavoritesEvent.addFavorite({
    required String movieId,
    String? movieTitle,
    String? moviePoster,
    String? movieType,
    @Default('Default') String folder,
  }) = AddFavoriteEvent;

  const factory FavoritesEvent.removeFavorite({required String movieId}) =
      RemoveFavoriteEvent;

  const factory FavoritesEvent.clearFavorites() = ClearFavorites;

  const factory FavoritesEvent.checkFavoriteStatus({required String movieId}) =
      CheckFavoriteStatus;
}
