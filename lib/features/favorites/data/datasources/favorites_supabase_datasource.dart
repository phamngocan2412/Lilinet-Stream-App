import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/favorite_model.dart';

@lazySingleton
class FavoritesSupabaseDataSource {
  final SupabaseClient supabaseClient;

  FavoritesSupabaseDataSource(this.supabaseClient);

  Future<List<FavoriteModel>> getFavorites({
    int page = 1,
    int limit = 20,
  }) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final from = (page - 1) * limit;
    final to = from + limit - 1;

    final response = await supabaseClient
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .range(from, to);

    return (response as List)
        .map((json) => FavoriteModel.fromJson(json))
        .toList();
  }

  Future<FavoriteModel> addFavorite({
    required String movieId,
    String? movieTitle,
    String? moviePoster,
    String? movieType,
    String folder = 'Default',
  }) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final data = {
      'user_id': userId,
      'movie_id': movieId,
      'movie_title': movieTitle,
      'movie_poster': moviePoster,
      'movie_type': movieType,
      'folder': folder,
    };

    final response = await supabaseClient
        .from('favorites')
        .insert(data)
        .select()
        .single();

    return FavoriteModel.fromJson(response);
  }

  Future<void> removeFavorite(String movieId) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await supabaseClient
        .from('favorites')
        .delete()
        .eq('user_id', userId)
        .eq('movie_id', movieId);
  }

  Future<bool> isFavorite(String movieId) async {
    final userId = supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      return false;
    }

    final response = await supabaseClient
        .from('favorites')
        .select('id')
        .eq('user_id', userId)
        .eq('movie_id', movieId)
        .maybeSingle();

    return response != null;
  }
}
