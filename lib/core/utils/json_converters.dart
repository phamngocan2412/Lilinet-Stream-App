import 'package:freezed_annotation/freezed_annotation.dart';

class StringToDoubleConverter implements JsonConverter<double?, dynamic> {
  const StringToDoubleConverter();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is double) return json;
    if (json is int) return json.toDouble();
    if (json is String) {
      return double.tryParse(json);
    }
    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}

class StringToIntConverter implements JsonConverter<int?, dynamic> {
  const StringToIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is double) return json.toInt();
    if (json is String) {
      return int.tryParse(json);
    }
    return null;
  }

  @override
  dynamic toJson(int? object) => object;
}

class StringToIntConverterRequired implements JsonConverter<int, dynamic> {
  const StringToIntConverterRequired();

  @override
  int fromJson(dynamic json) {
    if (json is int) return json;
    if (json is double) return json.toInt();
    if (json is String) {
      return int.tryParse(json) ?? 0;
    }
    return 0; // Default fallback
  }

  @override
  dynamic toJson(int object) => object;
}

class AnyToStringConverter implements JsonConverter<String, dynamic> {
  const AnyToStringConverter();

  @override
  String fromJson(dynamic json) {
    if (json == null) return '';
    return json.toString();
  }

  @override
  dynamic toJson(String object) => object;
}

class AnyToStringNullableConverter implements JsonConverter<String?, dynamic> {
  const AnyToStringNullableConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;
    final str = json.toString();

    // Filter out invalid image URLs, dates, and strings
    if (str == 'null' ||
        str == 'undefined' ||
        str == 'NaN' ||
        str.contains('originalnull') ||
        str.contains('originalundefined') ||
        str.isEmpty) {
      return null;
    }

    return str;
  }

  @override
  dynamic toJson(String? object) => object;
}

class EpisodeImageConverter implements JsonConverter<String?, dynamic> {
  const EpisodeImageConverter();

  @override
  String? fromJson(dynamic json) {
    if (json == null) return null;

    if (json is String) {
      if (json == 'null' || json.isEmpty) return null;
      return json;
    }

    if (json is Map) {
      return (json['mobile'] ?? json['hd'])?.toString();
    }

    return null;
  }

  @override
  dynamic toJson(String? object) => object;
}
