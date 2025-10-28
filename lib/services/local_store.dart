import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';

class LocalStore {
  static const _key = 'catbook_posts';

  static Future<List<Post>> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    return Post.decodeList(data);
  }

  static Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, Post.encodeList(posts));
  }
}
