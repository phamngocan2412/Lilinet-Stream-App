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

    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      memCacheWidth: memCacheWidth ??
          ((width != null && width!.isFinite)
              ? (width! * pixelRatio).toInt()
              : 700), // Fallback to prevent OOM with infinite width
      memCacheHeight: memCacheHeight ??
          ((height != null && height!.isFinite)
              ? (height! * pixelRatio).toInt()
              : null),
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

        // Calculate optimal cache width
        int? memCacheWidth;

        // 1. Use explicit width if valid
        if (width != null && width!.isFinite) {
          memCacheWidth = (width! * devicePixelRatio).toInt();
        }
        // 2. Use constraint width if explicit width is infinite/null and constraint is finite
        else if (constraints.hasBoundedWidth) {
          memCacheWidth = (constraints.maxWidth * devicePixelRatio).toInt();
        }
        // 3. Fallback
        else {
          memCacheWidth = 700;
        }

        // Ensure minimum cache width of 1 to prevent errors
        if (memCacheWidth != null && memCacheWidth < 1) {
          memCacheWidth = 1;
        }

        // Calculate optimal cache height (only if explicit height is provided)
        int? memCacheHeight;
        if (height != null && height!.isFinite) {
          memCacheHeight = (height! * devicePixelRatio).toInt();
          // Ensure minimum cache height
          if (memCacheHeight < 1) memCacheHeight = 1;
        }

        final image = CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          fadeInDuration: const Duration(milliseconds: 300),
          fadeOutDuration: const Duration(milliseconds: 100),
          memCacheWidth: memCacheWidth,
          memCacheHeight: memCacheHeight,
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
      },
    );
  }
}
