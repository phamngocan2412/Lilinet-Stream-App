import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final String id;
  final String title;
  final String? description;
  final int number;
  final int? season;
  final String? image;
  final String? url;
  final DateTime? releaseDate;

  const Episode({
    required this.id,
    required this.title,
    this.description,
    required this.number,
    this.season,
    this.image,
    this.url,
    this.releaseDate,
  });

  @override
  List<Object?> get props =>
      [id, title, description, number, season, image, url, releaseDate];
}
