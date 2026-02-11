import 'package:equatable/equatable.dart';

enum SortBy { popularity, releaseDate, rating, title }

enum MediaType { all, movie, tvSeries }

class FilterOptions extends Equatable {
  final MediaType mediaType;
  final List<String> genres;
  final int? yearFrom;
  final int? yearTo;
  final double? minRating;
  final SortBy sortBy;
  final String? country;

  const FilterOptions({
    this.mediaType = MediaType.all,
    this.genres = const [],
    this.yearFrom,
    this.yearTo,
    this.minRating,
    this.sortBy = SortBy.popularity,
    this.country,
  });

  FilterOptions copyWith({
    MediaType? mediaType,
    List<String>? genres,
    int? yearFrom,
    int? yearTo,
    double? minRating,
    SortBy? sortBy,
    String? country,
  }) {
    return FilterOptions(
      mediaType: mediaType ?? this.mediaType,
      genres: genres ?? this.genres,
      yearFrom: yearFrom ?? this.yearFrom,
      yearTo: yearTo ?? this.yearTo,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [
        mediaType,
        genres,
        yearFrom,
        yearTo,
        minRating,
        sortBy,
        country,
      ];
}
