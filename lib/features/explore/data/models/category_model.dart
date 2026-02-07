import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import '../../domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
@HiveType(typeId: 8)
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String description,
    @HiveField(3) String? icon,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Category toEntity() {
    return Category(id: id, name: name, description: description, icon: icon);
  }
}
