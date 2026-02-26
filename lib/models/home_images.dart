class RandomImages {
  final String id;
  final String author;
  final String downloadUrl;

  RandomImages({
    required this.id,
    required this.author,
    required this.downloadUrl,
  });

  factory RandomImages.fromJson(Map<String, dynamic> json) {
    return RandomImages(
      id: json['id'].toString(),
      author: json['author'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }
}