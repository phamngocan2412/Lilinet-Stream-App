import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/cached_image.dart';
import '../bloc/history_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';

class RecentlyWatchedPage extends StatelessWidget {
  const RecentlyWatchedPage({super.key});

  @override
  Widget build(BuildContext context) {
    // HistoryBloc is provided globally in MyApp
    // Just trigger a load if needed, but BlocBuilder handles listening
    // We can add a listener or just rely on state
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue Watching'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<HistoryBloc>().loadHistory(),
          ),
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryError) {
            return Center(child: Text(state.message));
          } else if (state is HistoryEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No recently watched movies'),
                ],
              ),
            );
          } else if (state is HistoryLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final item = state.history[index];
                final progress = item.positionSeconds / item.durationSeconds;
                final percentage = (progress * 100).clamp(0, 100).toInt();

                return Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(bottom: 12),
                  color: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  elevation: 0,
                  child: InkWell(
                    onTap: () {
                      context.read<VideoPlayerBloc>().add(
                        PlayVideo(
                          episodeId: item.episodeId ?? item.mediaId,
                          mediaId: item.mediaId,
                          title: item.title,
                          posterUrl: item.posterUrl,
                          episodeTitle: item.episodeTitle,
                          startPosition: Duration(
                            seconds: item.positionSeconds,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        SizedBox(
                          width: 120,
                          height: 80,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              AppCachedImage(
                                imageUrl: item.posterUrl ?? '',
                                fit: BoxFit.cover,
                              ),
                              Container(color: Colors.black38),
                              const Center(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              // Progress Bar
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                                if (item.episodeTitle != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    item.episodeTitle!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 8),
                                Text(
                                  'Stopped at $percentage%',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.6),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Delete Button
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 20,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                          onPressed: () {
                            context.read<HistoryBloc>().deleteProgress(
                              item.mediaId,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
