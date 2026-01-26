import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'loading_indicator.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.memCacheWidth,
    this.memCacheHeight,
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

    // Optimization: Skip LayoutBuilder if explicit memCacheWidth is provided
    if (memCacheWidth != null) {
      int? optimalMemCacheHeight = memCacheHeight;
      // Only access MediaQuery if strictly necessary for height calculation
      if (optimalMemCacheHeight == null && height != null && height!.isFinite) {
        optimalMemCacheHeight =
            (height! * MediaQuery.of(context).devicePixelRatio).toInt();
      }
      return _buildImage(context, memCacheWidth, optimalMemCacheHeight);
    }

    // Optimization: Skip LayoutBuilder if explicit width is provided and finite
    if (width != null && width!.isFinite) {
      final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
      final optimalMemCacheWidth = (width! * devicePixelRatio).toInt();

      int? optimalMemCacheHeight = memCacheHeight;
      if (optimalMemCacheHeight == null && height != null && height!.isFinite) {
        optimalMemCacheHeight = (height! * devicePixelRatio).toInt();
      }

      return _buildImage(context, optimalMemCacheWidth, optimalMemCacheHeight);
    }

    // Fallback: Use LayoutBuilder to determine size from constraints
    return LayoutBuilder(
      builder: (context, constraints) {
        final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

        // Calculate optimal cache width
        int? optimalMemCacheWidth; // We know memCacheWidth is null here

        if (constraints.hasBoundedWidth) {
          optimalMemCacheWidth =
              (constraints.maxWidth * devicePixelRatio).toInt();
        } else {
          optimalMemCacheWidth = 700; // Fallback
        }

        // Calculate optimal cache height
        int? optimalMemCacheHeight = memCacheHeight;
        if (optimalMemCacheHeight == null &&
            height != null &&
            height!.isFinite) {
          optimalMemCacheHeight = (height! * devicePixelRatio).toInt();
        }

        return _buildImage(
            context, optimalMemCacheWidth, optimalMemCacheHeight);
      },
    );
  }

  Widget _buildImage(BuildContext context, int? cacheWidth, int? cacheHeight) {
    // Ensure minimum cache width/height of 1 to prevent errors
    if (cacheWidth != null && cacheWidth < 1) cacheWidth = 1;
    if (cacheHeight != null && cacheHeight < 1) cacheHeight = 1;

    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      memCacheWidth: cacheWidth,
      memCacheHeight: cacheHeight,
      maxWidthDiskCache: 800, // Limit disk cache size
      maxHeightDiskCache: 1200,
      placeholder: (context, url) => Container(
        color: Colors.grey[850],
        child: const Center(
          child: LoadingIndicator(size: 30),
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
