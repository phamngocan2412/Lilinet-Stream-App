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

    return LayoutBuilder(
      builder: (context, constraints) {
        final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

        // Calculate optimal cache width
        int? optimalMemCacheWidth = memCacheWidth;

        // 1. Use explicit width if valid
        if (optimalMemCacheWidth == null) {
          if (width != null && width!.isFinite) {
            optimalMemCacheWidth = (width! * devicePixelRatio).toInt();
          }
          // 2. Use constraint width if explicit width is infinite/null and constraint is finite
          else if (constraints.hasBoundedWidth) {
            optimalMemCacheWidth = (constraints.maxWidth * devicePixelRatio).toInt();
          }
          // 3. Fallback
          else {
            optimalMemCacheWidth = 700;
          }
        }

        // Ensure minimum cache width of 1 to prevent errors
        if (optimalMemCacheWidth != null && optimalMemCacheWidth < 1) {
          optimalMemCacheWidth = 1;
        }

        // Calculate optimal cache height (only if explicit height is provided)
        int? optimalMemCacheHeight = memCacheHeight;
        if (optimalMemCacheHeight == null && height != null && height!.isFinite) {
          optimalMemCacheHeight = (height! * devicePixelRatio).toInt();
          // Ensure minimum cache height
          if (optimalMemCacheHeight < 1) optimalMemCacheHeight = 1;
        }

        final image = CachedNetworkImage(
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
