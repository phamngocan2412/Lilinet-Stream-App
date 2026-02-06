/// Streaming configuration for providers and servers
///
/// Centralized configuration for all streaming-related constants.
/// This allows easy updates without modifying business logic.
class StreamingConfig {
  StreamingConfig._();

  // ============================================
  // Default Settings
  // ============================================

  /// Default provider for Anime
  static const String defaultAnimeProvider = 'animepahe';

  /// Default provider for Movies/TV
  static const String defaultMovieProvider = 'goku';

  /// Default provider fallback (if type unknown)
  static const String defaultProvider = defaultAnimeProvider;

  // ============================================
  // Provider Lists
  // ============================================

  /// Anime streaming providers in priority order
  static const List<String> animeProviders = [
    'animepahe',
    'animekai',
    'kickassanime',
    'animesaturn',
    'hianime', // Currently blocked by Cloudflare
    'animeunity', // Currently blocked (403)
    'gogoanime', // Missing in backend
  ];

  /// Movie/TV streaming providers in priority order
  static const List<String> movieProviders = [
    'goku',
    'flixhq',
    'himovies',
    'sflix',
    'dramacool',
    'viewasian',
  ];

  /// All providers combined
  static List<String> get allProviders => [...animeProviders, ...movieProviders];

  // ============================================
  // Server Lists
  // ============================================

  /// Default servers to try in order
  static const List<String> defaultServers = [
    'vidcloud',
    'upcloud',
    'megaup',
  ];

  /// Anime-specific servers
  static const List<String> animeServers = [
    'vidcloud',
    'vidstreaming',
    'streamsb',
    'streamtape',
  ];

  /// Movie-specific servers
  static const List<String> movieServers = [
    'upcloud',
    'vidcloud',
    'mixdrop',
  ];

  // ============================================
  // Provider Metadata
  // ============================================

  /// Human-readable names for providers
  static const Map<String, String> providerNames = {
    'hianime': 'HiAnime (Zoro)',
    'zoro': 'HiAnime (Legacy)',
    'gogoanime': 'GogoAnime',
    'animepahe': 'AnimePahe',
    'animekai': 'AnimeKai',
    'kickassanime': 'KickAssAnime',
    'animeunity': 'AnimeUnity',
    'animesaturn': 'AnimeSaturn',

    'goku': 'Goku.sx',
    'flixhq': 'FlixHQ',
    'himovies': 'HiMovies',
    'sflix': 'SFlix',
    'dramacool': 'DramaCool',
    'viewasian': 'ViewAsian',
  };

  /// Provider descriptions
  static const Map<String, String> providerDescriptions = {
    'hianime': 'Best Quality (Recommended)',
    'gogoanime': 'Stable & Fast',
    'animepahe': 'Low Data Usage',
    'animekai': 'Clean Interface',
    'kickassanime': 'Good Player',
    'animeunity': 'Italian Sub',
    'animesaturn': 'Italian Sub',

    'goku': 'Best for Movies/TV',
    'flixhq': 'Alternative Source',
    'himovies': 'High Quality',
    'sflix': 'Large Library',
    'dramacool': 'Asian Dramas',
    'viewasian': 'Asian Movies',
  };

  // ============================================
  // Server Metadata
  // ============================================

  /// Human-readable names for servers
  static const Map<String, String> serverNames = {
    'vidcloud': 'VidCloud',
    'upcloud': 'UpCloud',
    'megaup': 'MegaUp',
    'vidstreaming': 'VidStreaming',
    'streamsb': 'StreamSB',
    'streamtape': 'StreamTape',
    'mixdrop': 'MixDrop',
    'filemoon': 'FileMoon',
  };

  // ============================================
  // Helper Methods
  // ============================================

  /// Check if provider is for anime
  static bool isAnimeProvider(String provider) {
    // Map legacy names
    if (provider == 'zoro') provider = 'hianime';
    return animeProviders.contains(provider.toLowerCase());
  }

  /// Check if provider is for movies
  static bool isMovieProvider(String provider) {
    return movieProviders.contains(provider.toLowerCase());
  }

  /// Get display name for provider
  static String getProviderName(String provider) {
    return providerNames[provider.toLowerCase()] ?? provider.toUpperCase();
  }

  /// Get description for provider
  static String getProviderDescription(String provider) {
    return providerDescriptions[provider.toLowerCase()] ?? '';
  }

  /// Get display name for server
  static String getServerName(String server) {
    return serverNames[server.toLowerCase()] ?? _capitalize(server);
  }

  /// Get servers for a provider type
  static List<String> getServersForProvider(String provider) {
    if (isAnimeProvider(provider)) {
      return animeServers;
    }
    return movieServers;
  }

  /// Get fallback providers (excluding the primary one)
  static List<String> getFallbackProviders(String primaryProvider, bool isAnime) {
    final allList = isAnime ? animeProviders : movieProviders;
    // Try providers of the same type first, then others
    final otherList = isAnime ? movieProviders : animeProviders;

    final combined = [...allList, ...otherList];

    return combined.where((p) => p != primaryProvider).toList();
  }

  static String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  /// Determine best provider based on genres and user preferences
  static String determineProvider({
    required List<String>? genres,
    String? movieProviderPref,
    String? animeProviderPref,
  }) {
    if (genres == null || genres.isEmpty) {
      return movieProviderPref ?? defaultMovieProvider;
    }

    final isAnime = genres.any(
      (g) =>
          g.toLowerCase().contains('anime') ||
          g.toLowerCase().contains('animation'),
    );

    if (isAnime) {
      return animeProviderPref ?? defaultAnimeProvider;
    }

    return movieProviderPref ?? defaultMovieProvider;
  }
}
