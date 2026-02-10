import 'package:flutter/foundation.dart';

/// Helper class to normalize and handle media type comparisons
///
/// Backend may return various formats like 'TV Series', 'tv', 'TV', 'anime', etc.
/// This helper ensures consistent comparison across the app.
class MediaTypeHelper {
  MediaTypeHelper._(); // Private constructor to prevent instantiation

  /// Normalizes a media type string to a standard format
  ///
  /// Returns one of: 'tv', 'movie', 'anime', or 'unknown'
  static String normalize(String? mediaType) {
    if (mediaType == null || mediaType.isEmpty) {
      return 'unknown';
    }

    final normalized = mediaType.toLowerCase().trim();

    // Anime variations - check first to prioritize anime classification
    if (normalized == 'anime' ||
        normalized == 'animation' ||
        normalized.contains('anime')) {
      return 'anime';
    }

    // Special case: TV series that might be anime (e.g., "tv series" with anime genres)
    if (normalized == 'tv series' || normalized.contains('tv')) {
      return 'tv';
    }

    // Movie variations
    if (normalized == 'movie' ||
        normalized == 'film' ||
        normalized == 'movies') {
      return 'movie';
    }

    return normalized;
  }

  /// Checks if the media type represents a TV series (including anime)
  ///
  /// This is used for auto-play and preloading logic
  static bool isSeries(String? mediaType) {
    final normalized = normalize(mediaType);
    return normalized == 'tv' || normalized == 'anime';
  }

  /// Checks if the media type is specifically anime
  static bool isAnime(String? mediaType) {
    return normalize(mediaType) == 'anime';
  }

  /// Checks if the media type is a movie
  static bool isMovie(String? mediaType) {
    return normalize(mediaType) == 'movie';
  }

  /// Checks if the media type is TV (not anime)
  static bool isTV(String? mediaType) {
    return normalize(mediaType) == 'tv';
  }

  /// Gets the display label for a media type
  ///
  /// Returns a user-friendly string like 'TV Series', 'Movie', 'Anime'
  static String getDisplayLabel(String? mediaType) {
    final normalized = normalize(mediaType);

    switch (normalized) {
      case 'tv':
        return 'TV Series';
      case 'movie':
        return 'Movie';
      case 'anime':
        return 'Anime';
      default:
        return mediaType?.trim() ?? 'Unknown';
    }
  }

  /// Debug helper to log media type normalization
  static void debugPrintNormalization(String? original, String? normalized) {
    if (kDebugMode && original != normalized) {
      debugPrint('📝 MediaType normalized: "$original" → "$normalized"');
    }
  }
}
