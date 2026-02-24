class RandomImages {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  RandomImages({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  /// From JSON
  factory RandomImages.fromJson(Map<String, dynamic> json) {
    return RandomImages(
      albumId: json['albumId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  /// CopyWith (Good for state management)
  RandomImages copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) {
    return RandomImages(
      albumId: albumId ?? this.albumId,
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  @override
  String toString() {
    return 'RandomImages(albumId: $albumId, id: $id, title: $title, url: $url, thumbnailUrl: $thumbnailUrl)';
  }
}