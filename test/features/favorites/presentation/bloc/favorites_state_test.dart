import 'package:flutter_test/flutter_test.dart';
import 'package:lilinet_app/features/favorites/domain/entities/favorite.dart';
import 'package:lilinet_app/features/favorites/presentation/bloc/favorites_state.dart';

void main() {
  group('FavoritesState', () {
    test(
        'FavoritesLoaded should correctly identify favorites using isFavorite extension',
        () {
      final favorite = Favorite(
        id: '1',
        userId: 'user1',
        movieId: 'movie1',
        createdAt: DateTime.now(),
      );

      final state = FavoritesLoaded(
        favorites: [favorite],
        favoriteIds: {favorite.movieId},
      );

      expect(state.isFavorite('movie1'), true);
      expect(state.isFavorite('movie2'), false);
    });
  });
}
