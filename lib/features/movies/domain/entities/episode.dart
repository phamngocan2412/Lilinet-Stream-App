import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    required String id,
    required String title,
    String? description,
    required int number,
    int? season,
    String? image,
    String? url,
    DateTime? releaseDate,
  }) = _Episode;
}
