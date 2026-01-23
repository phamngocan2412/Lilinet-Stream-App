import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../widgets/comment_section.dart'; // Import CommentModel
import 'comments_state.dart';

@singleton
class CommentsCubit extends Cubit<CommentsState> {
  // Simple in-memory cache: videoId -> List<CommentModel>
  final Map<String, List<CommentModel>> _cache = {};

  CommentsCubit() : super(CommentsInitial());

  Future<void> loadComments(String videoId) async {
    // Return cached if available
    if (_cache.containsKey(videoId)) {
      emit(CommentsLoaded(videoId, _cache[videoId]!));
      return;
    }

    emit(CommentsLoading(videoId));

    // --- MOCK API ---
    await Future.delayed(const Duration(seconds: 1));

    final List<CommentModel> mockComments = [
      CommentModel(
        id: '1',
        userName: 'Sarah Jenkins',
        userAvatarUrl: 'https://i.pravatar.cc/150?u=1',
        content:
            'This episode was absolutely mind-blowing! The animation quality has improved so much.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      CommentModel(
        id: '2',
        userName: 'OtakuKing99',
        content: 'Does anyone know the name of the OST playing at 12:30?',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      CommentModel(
        id: '3',
        userName: 'AnimeLover',
        userAvatarUrl: 'https://i.pravatar.cc/150?u=3',
        content: 'Can\'t wait for the next season!',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
    // ----------------

    _cache[videoId] = mockComments;
    emit(CommentsLoaded(videoId, mockComments));
  }

  Future<void> addComment(String videoId, String content) async {
    // --- MOCK POST ---
    await Future.delayed(const Duration(milliseconds: 500));

    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: 'You',
      content: content,
      createdAt: DateTime.now(),
    );
    // ----------------

    final currentList = _cache[videoId] ?? [];
    final newList = [newComment, ...currentList];

    _cache[videoId] = newList;
    emit(CommentsLoaded(videoId, newList));
  }
}
