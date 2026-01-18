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

    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      memCacheWidth: memCacheWidth ??
          ((width != null && width!.isFinite) ? (width! * 2).toInt() : 700),
      memCacheHeight: memCacheHeight ??
          ((height != null && height!.isFinite) ? (height! * 2).toInt() : null),
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
