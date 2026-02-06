import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getComments(String videoId);
  Future<CommentModel> addComment({
    required String videoId,
    required String content,
    String? parentId,
  });
  Future<void> likeComment(String commentId);
  Future<void> dislikeComment(String commentId);
  Future<List<CommentModel>> getReplies(String commentId);
  Future<List<CommentModel>> getTrendingComments({int limit = 5});
  Future<List<String>> getLikedCommentIds(String videoId);
  Stream<List<Map<String, dynamic>>> getCommentStream(String videoId);
}

@LazySingleton(as: CommentRemoteDataSource)
class SupabaseCommentDataSource implements CommentRemoteDataSource {
  final SupabaseClient _supabase;

  SupabaseCommentDataSource(this._supabase);

  @override
  Stream<List<Map<String, dynamic>>> getCommentStream(String videoId) {
    final controller = StreamController<List<Map<String, dynamic>>>();

    _supabase
        .channel('public:comments:$videoId')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'comments',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'video_id',
            value: videoId,
          ),
          callback: (payload) {
            final record = payload.newRecord.isNotEmpty
                ? payload.newRecord
                : (payload.oldRecord.isNotEmpty ? payload.oldRecord : <String, dynamic>{});
            controller.add([record]);
          },
        )
        .subscribe();

    return controller.stream;
  }

  @override
  Future<List<CommentModel>> getComments(String videoId) async {
    try {
      // Get comments without profiles join (will get user info separately)
      final response = await _supabase
          .from('comments')
          .select('*')
          .eq('video_id', videoId)
          .eq('is_deleted', false)
          .isFilter('parent_id', null)
          .order('is_pinned', ascending: false) // Pinned first
          .order('created_at', ascending: false);

      // Get unique user IDs
      final userIds = response
          .map((r) => r['user_id'] as String)
          .toSet()
          .toList();

      // Fetch profiles separately
      final profilesResponse = await _supabase
          .from('profiles')
          .select('id, user_name, avatar_url')
          .filter('id', 'in', userIds);

      // Create profiles map
      final profilesMap = <String, Map<String, dynamic>>{};
      for (final profile in profilesResponse) {
        profilesMap[profile['id']] = profile;
      }

      // Merge data
      final mergedData = response.map((comment) {
        final userId = comment['user_id'] as String;
        final profile = profilesMap[userId];
        return {...comment, 'profiles': profile};
      }).toList();

      return _mapToCommentModels(mergedData);
    } catch (e) {
      // Return empty list if table doesn't exist or other errors
      debugPrint('⚠️ Comments table error: $e');
      return [];
    }
  }

  @override
  Future<CommentModel> addComment({
    required String videoId,
    required String content,
    String? parentId,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Insert comment
    final response = await _supabase
        .from('comments')
        .insert({
          'video_id': videoId,
          'user_id': user.id,
          'content': content,
          'parent_id': parentId,
          'created_at': DateTime.now().toIso8601String(),
        })
        .select()
        .single();

    // Get user profile
    final profile = await _supabase
        .from('profiles')
        .select('user_name, avatar_url')
        .eq('id', user.id)
        .single();

    return _mapToCommentModel({...response, 'profiles': profile});
  }

  @override
  Future<void> likeComment(String commentId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Check if already liked
    final existing = await _supabase
        .from('comment_likes')
        .select()
        .eq('comment_id', commentId)
        .eq('user_id', user.id)
        .maybeSingle();

    if (existing != null) {
      // Unlike
      await _supabase
          .from('comment_likes')
          .delete()
          .eq('comment_id', commentId)
          .eq('user_id', user.id);
    } else {
      // Like
      await _supabase.from('comment_likes').insert({
        'comment_id': commentId,
        'user_id': user.id,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  @override
  Future<void> dislikeComment(String commentId) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // Check if already disliked
    final existing = await _supabase
        .from('comment_dislikes')
        .select()
        .eq('comment_id', commentId)
        .eq('user_id', user.id)
        .maybeSingle();

    if (existing != null) {
      // Remove dislike
      await _supabase
          .from('comment_dislikes')
          .delete()
          .eq('comment_id', commentId)
          .eq('user_id', user.id);
    } else {
      // Dislike
      await _supabase.from('comment_dislikes').insert({
        'comment_id': commentId,
        'user_id': user.id,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  @override
  Future<List<CommentModel>> getReplies(String commentId) async {
    try {
      // Get replies without profiles join
      final response = await _supabase
          .from('comments')
          .select('*')
          .eq('parent_id', commentId)
          .eq('is_deleted', false)
          .order('created_at', ascending: true);

      if (response.isEmpty) return [];

      // Get unique user IDs
      final userIds = response
          .map((r) => r['user_id'] as String)
          .toSet()
          .toList();

      // Fetch profiles separately
      final profilesResponse = await _supabase
          .from('profiles')
          .select('id, user_name, avatar_url')
          .filter('id', 'in', userIds);

      // Create profiles map
      final profilesMap = <String, Map<String, dynamic>>{};
      for (final profile in profilesResponse) {
        profilesMap[profile['id']] = profile;
      }

      // Merge data
      final mergedData = response.map((comment) {
        final userId = comment['user_id'] as String;
        final profile = profilesMap[userId];
        return {...comment, 'profiles': profile};
      }).toList();

      return _mapToCommentModels(mergedData);
    } catch (e) {
      debugPrint('⚠️ Get replies error: $e');
      return [];
    }
  }

  @override
  Future<List<CommentModel>> getTrendingComments({int limit = 5}) async {
    try {
      // Get trending comments without profiles join
      final response = await _supabase
          .from('comments')
          .select('*')
          .isFilter('parent_id', null)
          .eq('is_deleted', false)
          .gte(
            'created_at',
            DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
          )
          .order('likes', ascending: false)
          .limit(limit);

      if (response.isEmpty) return [];

      // Get unique user IDs
      final userIds = response
          .map((r) => r['user_id'] as String)
          .toSet()
          .toList();

      // Fetch profiles separately
      final profilesResponse = await _supabase
          .from('profiles')
          .select('id, user_name, avatar_url')
          .filter('id', 'in', userIds);

      // Create profiles map
      final profilesMap = <String, Map<String, dynamic>>{};
      for (final profile in profilesResponse) {
        profilesMap[profile['id']] = profile;
      }

      // Merge data
      final mergedData = response.map((comment) {
        final userId = comment['user_id'] as String;
        final profile = profilesMap[userId];
        return {...comment, 'profiles': profile};
      }).toList();

      return _mapToCommentModels(mergedData);
    } catch (e) {
      debugPrint('⚠️ Get trending comments error: $e');
      return [];
    }
  }

  List<CommentModel> _mapToCommentModels(List<dynamic> data) {
    return data.map((item) => _mapToCommentModel(item)).toList();
  }

  @override
  Future<List<String>> getLikedCommentIds(String videoId) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return [];

      // Get all comments for this video
      final commentsResponse = await _supabase
          .from('comments')
          .select('id')
          .eq('video_id', videoId)
          .eq('is_deleted', false);

      if (commentsResponse.isEmpty) return [];

      final commentIds = commentsResponse
          .map((c) => c['id'] as String)
          .toList();

      // Get likes for these comments by current user
      final likesResponse = await _supabase
          .from('comment_likes')
          .select('comment_id')
          .eq('user_id', user.id)
          .filter('comment_id', 'in', commentIds);

      return likesResponse.map((like) => like['comment_id'] as String).toList();
    } catch (e) {
      debugPrint('⚠️ Get liked comment IDs error: $e');
      return [];
    }
  }

  CommentModel _mapToCommentModel(Map<String, dynamic> item) {
    final profile = item['profiles'] as Map<String, dynamic>?;

    return CommentModel(
      id: item['id'],
      videoId: item['video_id'],
      userName: profile?['user_name'] ?? 'Unknown',
      avatarUrl:
          profile?['avatar_url'] ?? 'https://ui-avatars.com/api/?name=User',
      content: item['content'],
      likes: item['likes'] ?? 0,
      dislikes: item['dislikes'] ?? 0,
      repliesCount: item['replies_count'] ?? 0,
      createdAt: DateTime.parse(item['created_at']),
      updatedAt: item['updated_at'] != null
          ? DateTime.parse(item['updated_at'])
          : null,
      parentId: item['parent_id'],
      mediaType: item['media_type'],
      isEdited: item['is_edited'] ?? false,
      isDeleted: item['is_deleted'] ?? false,
      isPinned: item['is_pinned'] ?? false,
    );
  }
}
