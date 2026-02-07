import 'package:equatable/equatable.dart';

enum ThemeMode { light, dark, system }

enum VideoQuality { auto, sd360, sd480, hd720, hd1080 }

enum PreferredServer { auto, vidcloud, upcloud, megaup }

class AppSettings extends Equatable {
  final ThemeMode themeMode;
  final String language;
  final bool autoPlay;
  final bool skipIntro;
  final VideoQuality defaultQuality;
  final bool downloadOverWifiOnly;
  final bool showNotifications;
  final bool adultContent;
  final String subtitleLanguage;
  final String movieProvider;
  final String animeProvider;
  final PreferredServer preferredServer;
  final String? pinCode;

  const AppSettings({
    this.themeMode = ThemeMode.dark,
    this.language = 'en',
    this.autoPlay = true,
    this.skipIntro = false,
    this.defaultQuality = VideoQuality.auto,
    this.downloadOverWifiOnly = true,
    this.showNotifications = true,
    this.adultContent = false,
    this.subtitleLanguage = 'en',
    this.movieProvider = 'flixhq', // Stable default
    this.animeProvider = 'animepahe', // Fixed and high quality
    this.preferredServer = PreferredServer.auto, // Auto-select best server
    this.pinCode,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? language,
    bool? autoPlay,
    bool? skipIntro,
    VideoQuality? defaultQuality,
    bool? downloadOverWifiOnly,
    bool? showNotifications,
    bool? adultContent,
    String? subtitleLanguage,
    String? movieProvider,
    String? animeProvider,
    PreferredServer? preferredServer,
    String? pinCode,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      autoPlay: autoPlay ?? this.autoPlay,
      skipIntro: skipIntro ?? this.skipIntro,
      defaultQuality: defaultQuality ?? this.defaultQuality,
      downloadOverWifiOnly: downloadOverWifiOnly ?? this.downloadOverWifiOnly,
      showNotifications: showNotifications ?? this.showNotifications,
      adultContent: adultContent ?? this.adultContent,
      subtitleLanguage: subtitleLanguage ?? this.subtitleLanguage,
      movieProvider: movieProvider ?? this.movieProvider,
      animeProvider: animeProvider ?? this.animeProvider,
      preferredServer: preferredServer ?? this.preferredServer,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.name,
      'language': language,
      'autoPlay': autoPlay,
      'skipIntro': skipIntro,
      'defaultQuality': defaultQuality.name,
      'downloadOverWifiOnly': downloadOverWifiOnly,
      'showNotifications': showNotifications,
      'adultContent': adultContent,
      'subtitleLanguage': subtitleLanguage,
      'movieProvider': movieProvider,
      'animeProvider': animeProvider,
      'preferredServer': preferredServer.name,
      'pinCode': pinCode,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      themeMode: ThemeMode.values.firstWhere(
        (e) => e.name == (json['themeMode'] ?? 'dark'),
        orElse: () => ThemeMode.dark,
      ),
      language: json['language'] ?? 'en',
      autoPlay: json['autoPlay'] ?? true,
      skipIntro: json['skipIntro'] ?? false,
      defaultQuality: VideoQuality.values.firstWhere(
        (e) => e.name == (json['defaultQuality'] ?? 'auto'),
        orElse: () => VideoQuality.auto,
      ),
      downloadOverWifiOnly: json['downloadOverWifiOnly'] ?? true,
      showNotifications: json['showNotifications'] ?? true,
      adultContent: json['adultContent'] ?? false,
      subtitleLanguage: json['subtitleLanguage'] ?? 'en',
      movieProvider: json['movieProvider'] ?? 'flixhq',
      animeProvider: json['animeProvider'] ?? 'animepahe',
      preferredServer: PreferredServer.values.firstWhere(
        (e) => e.name == (json['preferredServer'] ?? 'auto'),
        orElse: () => PreferredServer.auto,
      ),
      pinCode: json['pinCode'],
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        language,
        autoPlay,
        skipIntro,
        defaultQuality,
        downloadOverWifiOnly,
        showNotifications,
        adultContent,
        subtitleLanguage,
        movieProvider,
        animeProvider,
        preferredServer,
        pinCode,
      ];
}
