import 'package:injectable/injectable.dart';
import '../../features/movies/domain/entities/movie.dart';

/// Service for detecting whether content is anime or not
///
/// Uses multiple heuristics with priority:
/// 1. Check anime keywords in title (highest confidence)
/// 2. Check origin country (JP, KR = anime, US/UK/CA = western)
/// 3. Check western studio keywords (Pixar, Disney, DreamWorks)
/// 4. TV Series + Animation fallback (lowest confidence)
@injectable
class AnimeDetectionService {
  /// TMDB Animation genre
  static const int animationGenreId = 16;

  /// Countries that produce anime
  static const List<String> animeCountries = [
    'JP',
    'Japan',
    'KR',
    'Korea',
    'South Korea',
  ];

  /// Western countries - animation from these is NOT anime
  static const List<String> westernCountries = [
    'US',
    'USA',
    'United States',
    'UK',
    'United Kingdom',
    'CA',
    'Canada',
    'FR',
    'France',
    'DE',
    'Germany',
    'AU',
    'Australia',
  ];

  /// Western animation studios - definitely NOT anime
  static const List<String> westernStudios = [
    'pixar',
    'disney',
    'dreamworks',
    'illumination',
    'warner',
    'cartoon network',
    'nickelodeon',
    'sony pictures animation',
    'blue sky',
    'laika',
    'aardman',
  ];

  /// Western animation series/movies - definitely NOT anime
  static const List<String> westernTitles = [
    'toy story',
    'frozen',
    'moana',
    'encanto',
    'coco',
    'inside out',
    'finding nemo',
    'finding dory',
    'the incredibles',
    'monsters',
    'cars',
    'ratatouille',
    'wall-e',
    'brave',
    'tangled',
    'big hero',
    'zootopia',
    'wreck-it ralph',
    'luca',
    'turning red',
    'elemental',
    'shrek',
    'kung fu panda',
    'how to train your dragon',
    'madagascar',
    'the croods',
    'trolls',
    'minions',
    'despicable me',
    'the secret life of pets',
    'sing',
    'the grinch',
    'boss baby',
    'spider-verse',
    'spongebob',
    'avatar the last airbender',
    'the legend of korra',
    'adventure time',
    'regular show',
    'gravity falls',
    'steven universe',
    'the owl house',
    'amphibia',
    'rick and morty',
    'family guy',
    'the simpsons',
    'south park',
    'futurama',
    'archer',
    'bob\'s burgers',
    'king of the hill',
    'american dad',
    'invincible',
    'arcane',
    'castlevania',
  ];

  /// Common anime keywords in titles
  static const List<String> animeKeywords = [
    // Major titles
    'jujutsu',
    'kaisen',
    'naruto',
    'one piece',
    'bleach',
    'dragon ball',
    'attack on titan',
    'demon slayer',
    'my hero academia',
    'hunter x hunter',
    'sword art online',
    'fullmetal alchemist',
    'death note',
    'code geass',
    'one punch man',
    'gintama',
    'fairy tail',
    'boku no hero',
    'kimetsu no yaiba',
    'shingeki no kyojin',
    'shippuden',
    'boruto',
    'nanatsu no taizai',
    'overlord',
    're:zero',
    'steins;gate',
    'chainsaw man',
    'spy x family',
    'mob psycho',
    'vinland saga',
    'black clover',
    'blue lock',
    'bocchi the rock',
    'oshi no ko',
    'frieren',
    'solo leveling',
    'dandadan',
    'kaiju no. 8',
    'mashle',
    'sakamoto days',
    'undead unluck',
    // Common abbreviations
    'fma',
    'sao',
    'aot',
    'bnha',
    'jjk',
    'mha',
    'hxh',
    'csm',
    'kny',
    // Japanese words commonly in anime titles
    'no hero',
    'no kyojin',
    'no yaiba',
    'monogatari',
    'mahou',
    'shoujo',
    'shounen',
    'seinen',
    'isekai',
    'tensei',
    'konosuba',
    'slime',
    'goblin',
    'shield hero',
    'mushoku',
    'danmachi',
    'rezero',
    'bunny girl',
    'quintessential quintuplets',
    'kaguya-sama',
    'horimiya',
    'tonikawa',
    'rent-a-girlfriend',
    'nisekoi',
    'oregairu',
    'toradora',
    'clannad',
    'violet evergarden',
    'your name',
    'kimi no na wa',
    'weathering with you',
    'suzume',
    'howl\'s moving castle',
    'spirited away',
    'totoro',
    'ghibli',
    'makoto shinkai',
  ];

  /// Detect if content is anime
  ///
  /// Returns true if content is likely anime, false otherwise
  bool isAnime(Movie movie, String type) {
    final title = movie.title.toLowerCase();
    final country = movie.country?.toLowerCase() ?? '';
    final production = movie.production?.toLowerCase() ?? '';

    // 1. Check if has Animation genre - required for anime
    final hasAnimation = movie.genres.any(
      (g) => g.toLowerCase().contains('animation'),
    );

    if (!hasAnimation) {
      return false;
    }

    // 2. EXCLUSION: Check for western animation titles first
    final isWesternTitle = westernTitles.any(
      (western) => title.contains(western),
    );
    if (isWesternTitle) {
      return false;
    }

    // 3. EXCLUSION: Check for western studios
    final isWesternStudio = westernStudios.any(
      (studio) => production.contains(studio) || title.contains(studio),
    );
    if (isWesternStudio) {
      return false;
    }

    // 4. Check for anime keywords in title (highest confidence)
    final hasAnimeKeyword = animeKeywords.any(
      (keyword) => title.contains(keyword),
    );
    if (hasAnimeKeyword) {
      return true;
    }

    // 5. Check origin country
    if (country.isNotEmpty) {
      // If from Japan/Korea -> anime
      final isAnimeCountry = animeCountries.any(
        (c) => country.contains(c.toLowerCase()),
      );
      if (isAnimeCountry) {
        return true;
      }

      // If from Western country -> NOT anime
      final isWesternCountry = westernCountries.any(
        (c) => country.contains(c.toLowerCase()),
      );
      if (isWesternCountry) {
        return false;
      }
    }

    // 6. TV Series + Animation = likely anime (fallback)
    // Only if we couldn't determine from other signals
    if (type.toLowerCase().contains('tv')) {
      return true;
    }

    // 7. Animation movies without clear signals -> likely NOT anime
    // (Most animated movies without anime keywords are western)
    return false;
  }

  /// Get detection reason for debugging
  String getDetectionReason(Movie movie, String type) {
    final title = movie.title.toLowerCase();
    final country = movie.country?.toLowerCase() ?? '';
    final production = movie.production?.toLowerCase() ?? '';

    final hasAnimation = movie.genres.any(
      (g) => g.toLowerCase().contains('animation'),
    );

    if (!hasAnimation) {
      return 'No Animation genre';
    }

    // Check western titles
    final westernTitle = westernTitles.cast<String?>().firstWhere(
      (western) => title.contains(western!),
      orElse: () => null,
    );
    if (westernTitle != null) {
      return 'Western animation title: "$westernTitle"';
    }

    // Check western studios
    final westernStudio = westernStudios.cast<String?>().firstWhere(
      (studio) => production.contains(studio!) || title.contains(studio),
      orElse: () => null,
    );
    if (westernStudio != null) {
      return 'Western studio: "$westernStudio"';
    }

    // Check anime keywords
    final animeKeyword = animeKeywords.cast<String?>().firstWhere(
      (keyword) => title.contains(keyword!),
      orElse: () => null,
    );
    if (animeKeyword != null) {
      return 'Anime keyword: "$animeKeyword"';
    }

    // Check country
    if (country.isNotEmpty) {
      final isAnimeCountry = animeCountries.any(
        (c) => country.contains(c.toLowerCase()),
      );
      if (isAnimeCountry) {
        return 'Origin country: $country (anime region)';
      }

      final isWesternCountry = westernCountries.any(
        (c) => country.contains(c.toLowerCase()),
      );
      if (isWesternCountry) {
        return 'Origin country: $country (western region)';
      }
    }

    if (type.toLowerCase().contains('tv')) {
      return 'Animation + TV Series (fallback - may be inaccurate)';
    }

    return 'Animation movie without clear signals (defaulting to western)';
  }
}
