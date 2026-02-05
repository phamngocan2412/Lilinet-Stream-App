import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive_ce.dart';
import '../../domain/entities/genre.dart';

part 'genre_model.freezed.dart';
part 'genre_model.g.dart';

@freezed
@HiveType(typeId: 7)
abstract class GenreModel with _$GenreModel {
  const GenreModel._();

  const factory GenreModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? icon,
  }) = _GenreModel;

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Genre toEntity() {
    return Genre(id: id, name: name, icon: icon);
  }
}
