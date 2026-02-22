import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_border_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/services/download_service.dart';
import '../../../../core/services/miniplayer_height_notifier.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../injection_container.dart';
import '../../../video_player/presentation/bloc/video_player_bloc.dart';
import '../../../video_player/presentation/bloc/video_player_event.dart';
import '../../domain/entities/downloaded_file.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  final DownloadService _downloadService = getIt<DownloadService>();
  List<DownloadedFile> _downloads = [];
  bool _isLoading = true;
  String _totalSize = '0 MB';

  @override
  void initState() {
    super.initState();
    _loadDownloads();
  }

  Future<void> _loadDownloads() async {
    setState(() => _isLoading = true);

    final downloads = await _downloadService.getDownloadedFiles();
    final totalSize = await _downloadService.getTotalDownloadSizeFormatted();

    if (mounted) {
      setState(() {
        _downloads = downloads;
        _totalSize = totalSize;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteDownload(DownloadedFile file) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Download'),
        content: Text(
          'Are you sure you want to delete "${file.displayTitle}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await _downloadService.deleteDownload(file.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${file.displayTitle}" deleted')),
        );
        _loadDownloads();
      }
    }
  }

  void _playDownload(DownloadedFile file) {
    context.read<VideoPlayerBloc>().add(
          PlayVideo(
            episodeId: file.movieId ?? file.id,
            mediaId: file.movieId ?? file.id,
            title: file.displayTitle,
            posterUrl: file.posterUrl,
            episodeTitle: file.displaySubtitle,
            mediaType: 'Movie',
          ),
        );

    // After playing, we need to load the local file
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<VideoPlayerBloc>().add(
              LoadVideo(url: 'file://${file.filePath}', headers: const {}),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Downloads',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_downloads.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: Text(
                  _totalSize,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: ListenableBuilder(
        listenable: getIt<MiniplayerHeightNotifier>(),
        builder: (context, _) {
          final miniplayerHeight = getIt<MiniplayerHeightNotifier>().height;

          if (_isLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (_downloads.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(bottom: miniplayerHeight),
              child: const EmptyStateWidget(
                icon: Icons.download_done,
                message: 'No Downloads\nVideos you download will appear here',
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _loadDownloads,
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: AppSpacing.sm,
                bottom: AppSpacing.lg + miniplayerHeight,
              ),
              itemCount: _downloads.length,
              itemBuilder: (context, index) {
                final file = _downloads[index];
                return _DownloadItem(
                  file: file,
                  onPlay: () => _playDownload(file),
                  onDelete: () => _deleteDownload(file),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _DownloadItem extends StatelessWidget {
  final DownloadedFile file;
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const _DownloadItem({
    required this.file,
    required this.onPlay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: InkWell(
        onTap: onPlay,
        borderRadius: BorderRadius.circular(AppBorderRadius.large),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                child: file.posterUrl != null
                    ? AppCachedImage(
                        imageUrl: file.posterUrl!,
                        width: 80,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 80,
                        height: 120,
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.movie,
                          size: 40,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
              const SizedBox(width: AppSpacing.lg),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.displayTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (file.displaySubtitle.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        file.displaySubtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(
                          Icons.storage,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          file.formattedSize,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          _formatDate(file.downloadedAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Actions
              Column(
                children: [
                  IconButton(
                    onPressed: onPlay,
                    icon: const Icon(Icons.play_circle_filled),
                    iconSize: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      if (diff.inHours == 0) return '${diff.inMinutes}m ago';
      return '${diff.inHours}h ago';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
