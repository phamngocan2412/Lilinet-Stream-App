// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lilinet_app/l10n/app_localizations.dart';
import '../../../../injection_container.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../bloc/history_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';

class RecentlyWatchedPage extends StatelessWidget {
  const RecentlyWatchedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continue Watching'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<HistoryBloc>().loadHistory(),
            tooltip: AppLocalizations.of(context)!.refresh,
          ),
        ],
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is HistoryError) {
            return Center(child: Text(state.message));
          } else if (state is HistoryEmpty) {
            return const EmptyStateWidget(
              icon: Icons.history,
              message: 'No recently watched movies',
            );
          } else if (state is HistoryLoaded) {
            return ListenableBuilder(
              listenable: getIt<MiniplayerHeightNotifier>(),
              builder: (context, _) {
                final miniplayerHeight =
                    getIt<MiniplayerHeightNotifier>().height;

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<HistoryBloc>().loadHistory();
                  },
                  child: ListView.builder(
                    cacheExtent: 300,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: miniplayerHeight + 16,
                    ),
                    itemCount: state.history.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        final hours = state.totalTimeSeconds ~/ 3600;
                        final minutes = (state.totalTimeSeconds % 3600) ~/ 60;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StatItemWidget(
                                icon: Icons.movie_filter_outlined,
                                value: '${state.totalVideos}',
                                label: 'Videos Watched',
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                              ),
                              StatItemWidget(
                                icon: Icons.timer_outlined,
                                value: '${hours}h ${minutes}m',
                                label: 'Total Time',
                              ),
                            ],
                          ),
                        );
                      }

                      final item = state.history[index - 1];
                      final progress =
                          item.positionSeconds / item.durationSeconds;
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
                              SizedBox(
                                width: 120,
                                height: 80,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    AppCachedImage(
                                      imageUrl: item.posterUrl ?? '',
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 80,
                                    ),
                                    Container(color: Colors.black38),
                                    const Center(
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: LinearProgressIndicator(
                                        value: progress,
                                        backgroundColor: Colors.transparent,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          theme.colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      if (item.episodeTitle != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          item.episodeTitle!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: theme
                                                .colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),
                                      Text(
                                        'Stopped at $percentage%',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                onPressed: () {
                                  context.read<HistoryBloc>().deleteProgress(
                                        item.mediaId,
                                        episodeId: item.episodeId,
                                      );
                                },
                                tooltip: AppLocalizations.of(context)!.delete,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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

class StatItemWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatItemWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, color: theme.colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
