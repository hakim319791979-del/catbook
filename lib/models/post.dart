import 'dart:convert';

class Post {
  final String id;
  final String name;
  final String caption;
  final String? imagePath;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.name,
    required this.caption,
    this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'caption': caption,
        'imagePath': imagePath,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        name: json['name'],
        caption: json['caption'],
        imagePath: json['imagePath'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  static String encodeList(List<Post> posts) =>
      jsonEncode(posts.map((p) => p.toJson()).toList());

  static List<Post> decodeList(String jsonStr) =>
      (jsonDecode(jsonStr) as List)
          .map((data) => Post.fromJson(Map<String, dynamic>.from(data)))
          .toList();
}