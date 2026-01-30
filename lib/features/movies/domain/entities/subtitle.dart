import 'package:freezed_annotation/freezed_annotation.dart';

part 'subtitle.freezed.dart';

@freezed
abstract class Subtitle with _$Subtitle {
  const factory Subtitle({required String url, required String lang}) =
      _Subtitle;
}
