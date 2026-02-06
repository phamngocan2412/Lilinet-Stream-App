import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../core/utils/time_formatter.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/comment_repository.dart';
import '../../../../injection_container.dart';

class HomeTrendingSection extends StatelessWidget {
  const HomeTrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeTrendingCubit>()..loadTrendingComments(),
      child: const HomeTrendingSectionView(),
    );
  }
}

class HomeTrendingSectionView extends StatelessWidget {
  const HomeTrendingSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTrendingCubit, HomeTrendingState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _buildLoadingShimmer(context),
          loaded: (comments) => _buildTrendingList(context, comments),
          empty: () => const SizedBox.shrink(),
          error: (message) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildLoadingShimmer(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.builder(
        cacheExtent: 300,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 240,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingList(BuildContext context, List<Comment> comments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.featuredCommentsTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              const Text('🔥', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 130,
          child: ListView.builder(
            cacheExtent: 300,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return TrendingCommentCard(
                comment: comment,
                onTap: () {
                  // Navigate to video with comment highlight
                  final mediaType = comment.mediaType ?? 'TV Series';
                  final videoId = comment.videoId;

                  // Validate videoId
                  if (videoId.isEmpty || videoId.startsWith('mock-')) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.cannotOpenMockVideo),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  context.push(
                    '/movie/$videoId?type=$mediaType',
                    extra: {'highlightCommentId': comment.id},
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TrendingCommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onTap;

  const TrendingCommentCard({
    super.key,
    required this.comment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info row
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(comment.avatarUrl),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        TimeFormatter.formatTimeAgo(context, comment.createdAt),
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // Trending badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.trending_up,
                        size: 12,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        comment.trendingScore.toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Comment content
            Expanded(
              child: Text(
                comment.content,
                style: const TextStyle(fontSize: 12, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(height: 6),

            // Stats row
            Row(
              children: [
                Icon(Icons.thumb_up, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${comment.likes}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.comment, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${comment.repliesCount}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// State Management for Trending Comments
abstract class HomeTrendingState {
  const HomeTrendingState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<Comment> comments) loaded,
    required T Function() empty,
    required T Function(String message) error,
  }) {
    if (this is HomeTrendingInitial) return initial();
    if (this is HomeTrendingLoading) return loading();
    if (this is HomeTrendingLoaded) {
      return loaded((this as HomeTrendingLoaded).comments);
    }
    if (this is HomeTrendingEmpty) return empty();
    if (this is HomeTrendingError) {
      return error((this as HomeTrendingError).message);
    }
    throw Exception('Unknown state');
  }
}

class HomeTrendingInitial extends HomeTrendingState {}

class HomeTrendingLoading extends HomeTrendingState {}

class HomeTrendingLoaded extends HomeTrendingState {
  final List<Comment> comments;
  const HomeTrendingLoaded(this.comments);
}

class HomeTrendingEmpty extends HomeTrendingState {}

class HomeTrendingError extends HomeTrendingState {
  final String message;
  const HomeTrendingError(this.message);
}

@injectable
class HomeTrendingCubit extends Cubit<HomeTrendingState> {
  final CommentRepository _repository;

  HomeTrendingCubit(this._repository) : super(HomeTrendingInitial());

  Future<void> loadTrendingComments() async {
    emit(HomeTrendingLoading());

    final result = await _repository.getTrendingComments(limit: 5);

    result.fold((failure) => emit(HomeTrendingError(failure.message)), (
      comments,
    ) {
      if (comments.isEmpty) {
        emit(HomeTrendingEmpty());
      } else {
        emit(HomeTrendingLoaded(comments));
      }
    });
  }

  Future<void> refreshTrendingComments() async {
    await loadTrendingComments();
  }
}
