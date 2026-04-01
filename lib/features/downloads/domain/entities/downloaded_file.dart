class DownloadedFile {
  final String id;
  final String fileName;
  final String filePath;
  final String? movieId;
  final String? movieTitle;
  final String? episodeTitle;
  final String? posterUrl;
  final int fileSize;
  final DateTime downloadedAt;
  final String url;

  DownloadedFile({
    required this.id,
    required this.fileName,
    required this.filePath,
    this.movieId,
    this.movieTitle,
    this.episodeTitle,
    this.posterUrl,
    required this.fileSize,
    required this.downloadedAt,
    required this.url,
  });

  String get displayTitle => movieTitle ?? fileName;
  String get displaySubtitle => episodeTitle ?? '';

  String get formattedSize {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    }
    if (fileSize < 1024 * 1024 * 1024) {
      return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(fileSize / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fileName': fileName,
    'filePath': filePath,
    'movieId': movieId,
    'movieTitle': movieTitle,
    'episodeTitle': episodeTitle,
    'posterUrl': posterUrl,
    'fileSize': fileSize,
    'downloadedAt': downloadedAt.toIso8601String(),
    'url': url,
  };

  factory DownloadedFile.fromJson(Map<String, dynamic> json) => DownloadedFile(
    id: json['id'],
    fileName: json['fileName'],
    filePath: json['filePath'],
    movieId: json['movieId'],
    movieTitle: json['movieTitle'],
    episodeTitle: json['episodeTitle'],
    posterUrl: json['posterUrl'],
    fileSize: json['fileSize'] ?? 0,
    downloadedAt: DateTime.parse(json['downloadedAt']),
    url: json['url'],
  );

  DownloadedFile copyWith({
    String? id,
    String? fileName,
    String? filePath,
    String? movieId,
    String? movieTitle,
    String? episodeTitle,
    String? posterUrl,
    int? fileSize,
    DateTime? downloadedAt,
    String? url,
  }) => DownloadedFile(
    id: id ?? this.id,
    fileName: fileName ?? this.fileName,
    filePath: filePath ?? this.filePath,
    movieId: movieId ?? this.movieId,
    movieTitle: movieTitle ?? this.movieTitle,
    episodeTitle: episodeTitle ?? this.episodeTitle,
    posterUrl: posterUrl ?? this.posterUrl,
    fileSize: fileSize ?? this.fileSize,
    downloadedAt: downloadedAt ?? this.downloadedAt,
    url: url ?? this.url,
  );
}
