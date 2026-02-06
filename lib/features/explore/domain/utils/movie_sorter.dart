import '../../../movies/domain/entities/movie.dart';
import '../../domain/entities/filter_options.dart';

class MovieSorter {
  /// Sorts a list of movies in-place based on the provided [SortBy] criteria.
  static void sort(List<Movie> movies, SortBy sortBy) {
    switch (sortBy) {
      case SortBy.rating:
        movies.sort((a, b) {
          final ratingA = a.rating ?? 0.0;
          final ratingB = b.rating ?? 0.0;
          return ratingB.compareTo(ratingA); // Descending
        });
        break;
      case SortBy.title:
        movies.sort((a, b) {
          final titleA = a.title;
          final titleB = b.title;
          return titleA.compareTo(titleB); // Ascending
        });
        break;
      case SortBy.releaseDate:
        movies.sort((a, b) {
          final dateA = a.releaseDate ?? '';
          final dateB = b.releaseDate ?? '';
          // Simple string comparison works for ISO dates (YYYY-MM-DD),
          // but let's be robust if empty. Descending (newest first).
          if (dateA.isEmpty) return 1;
          if (dateB.isEmpty) return -1;
          return dateB.compareTo(dateA);
        });
        break;
      case SortBy.popularity:
        // Often implicit from API, but if we had popularity data we'd sort here.
        // For now, keep original order or rely on API.
        break;
    }
  }
}
