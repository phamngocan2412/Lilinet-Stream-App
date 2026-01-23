import 'package:equatable/equatable.dart';
import 'episode.dart';

class Movie extends Equatable {
  final String id;
  final String title;
  final String? poster;
  final String? cover;
  final String? description;
  final double? rating;
  final String? releaseDate;
  final String type; // 'Movie' or 'TV Series'
  final String? episodeId;
  final List<String> genres;
  final int? totalEpisodes;
  final String? duration;
  final List<Episode>? episodes;
  final List<Movie>? recommendations;
  final String? country;
  final String? production;
  final List<String>? casts;
  final List<String>? tags;
  final String? provider;

  const Movie({
    required this.id,
    required this.title,
    this.poster,
    this.cover,
    this.description,
    this.rating,
    this.releaseDate,
    required this.type,
    this.episodeId,
    this.genres = const [],
    this.totalEpisodes,
    this.duration,
    this.episodes,
    this.recommendations,
    this.country,
    this.production,
    this.casts,
    this.tags,
    this.provider,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    poster,
    cover,
    description,
    rating,
    releaseDate,
    type,
    episodeId,
    genres,
    totalEpisodes,
    duration,
    episodes,
    recommendations,
    country,
    production,
    casts,
    tags,
    provider,
  ];
}
