import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../cache/app_image_cache_manager.dart';
import 'loading_indicator.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Widget? placeholder;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.memCacheWidth,
    this.memCacheHeight,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    // Show error widget immediately if URL is invalid
    if (imageUrl.isEmpty ||
        imageUrl == 'null' ||
        imageUrl == 'undefined' ||
        imageUrl.contains('originalnull') ||
        imageUrl.contains('originalundefined')) {
      final errorWidget = Container(
        width: width,
        height: height,
        color: Colors.grey[800],
        child: const Icon(Icons.broken_image, color: Colors.white54),
      );

      if (borderRadius != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius!),
          child: errorWidget,
        );
      }
      return errorWidget;
    }

    // Optimization: Skip LayoutBuilder if we already have explicit dimensions.
    // This reduces the widget tree depth and RenderObject overhead.
    if (memCacheWidth != null || (width != null && width!.isFinite)) {
      int? optimalMemCacheWidth = memCacheWidth;
      double? devicePixelRatio;

      // Calculate width if needed
      if (optimalMemCacheWidth == null && width != null && width!.isFinite) {
        devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
        optimalMemCacheWidth = (width! * devicePixelRatio).toInt();
      }

      if (optimalMemCacheWidth != null && optimalMemCacheWidth < 1) {
        optimalMemCacheWidth = 1;
      }

      // Calculate height if needed
      int? optimalMemCacheHeight = memCacheHeight;
      if (optimalMemCacheHeight == null && height != null && height!.isFinite) {
        devicePixelRatio ??= MediaQuery.of(context).devicePixelRatio;
        optimalMemCacheHeight = (height! * devicePixelRatio).toInt();
        if (optimalMemCacheHeight < 1) optimalMemCacheHeight = 1;
      }

      return _buildImage(context, optimalMemCacheWidth, optimalMemCacheHeight);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

        // Calculate optimal cache width based on constraints
        int? optimalMemCacheWidth;

        if (constraints.hasBoundedWidth) {
          optimalMemCacheWidth =
              (constraints.maxWidth * devicePixelRatio).toInt();
        } else {
          optimalMemCacheWidth = 700; // Fallback
        }

        if (optimalMemCacheWidth < 1) {
          optimalMemCacheWidth = 1;
        }

        int? optimalMemCacheHeight = memCacheHeight;
        if (optimalMemCacheHeight == null &&
            height != null &&
            height!.isFinite) {
          optimalMemCacheHeight = (height! * devicePixelRatio).toInt();
          if (optimalMemCacheHeight < 1) optimalMemCacheHeight = 1;
        }

        return _buildImage(
          context,
          optimalMemCacheWidth,
          optimalMemCacheHeight,
        );
      },
    );
  }

  Widget _buildImage(
    BuildContext context,
    int? optimalMemCacheWidth,
    int? optimalMemCacheHeight,
  ) {
    final image = CachedNetworkImage(
      cacheManager: AppImageCacheManager.instance,
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      memCacheWidth: optimalMemCacheWidth,
      memCacheHeight: optimalMemCacheHeight,
      maxWidthDiskCache: 800, // Limit disk cache size
      maxHeightDiskCache: 1200,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            color: Colors.grey[850],
            child: Center(
              child: LoadingIndicator(
                size: width != null && width! < 50 ? 15 : 30,
              ),
            ),
          ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.grey[800],
        child: const Icon(Icons.broken_image, color: Colors.white54),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: image,
      );
    }

    return image;
  }
}
