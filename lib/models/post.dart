class Post {
  final String id;
  final String catId;
  final String caption;
  final DateTime createdAt;
  final String? imageUrl;

  Post({
    required this.id,
    required this.catId,
    required this.caption,
    required this.createdAt,
    this.imageUrl,
  });
}