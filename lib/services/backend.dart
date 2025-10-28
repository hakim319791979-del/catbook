import 'dart:collection';
import '../models/cat.dart';
import '../models/post.dart';

abstract class Backend {
  Future<List<Post>> fetchFeed();
  Future<Cat> getCat(String catId);
  Future<void> createPost({required String catId, required String caption});
}

class InMemoryBackend implements Backend {
  final Map<String, Cat> _cats = {
    "c1": Cat(id: "c1", name: "Zubair"),
    "c2": Cat(id: "c2", name: "Mishmish"),
  };

  final List<Post> _posts = [
    Post(id: "p1", catId: "c1", caption: "First day on CatGram", createdAt: DateTime.now().subtract(const Duration(hours: 3))),
    Post(id: "p2", catId: "c2", caption: "Nap time.", createdAt: DateTime.now().subtract(const Duration(hours: 1))),
  ];

  @override
  Future<List<Post>> fetchFeed() async {
    final list = [..._posts]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  @override
  Future<Cat> getCat(String catId) async {
    final cat = _cats[catId];
    if (cat == null) throw Exception("Cat not found");
    return cat;
  }

  @override
  Future<void> createPost({required String catId, required String caption}) async {
    final id = "p${_posts.length + 1}";
    _posts.add(Post(id: id, catId: catId, caption: caption, createdAt: DateTime.now()));
  }

  UnmodifiableListView<Post> get snapshot => UnmodifiableListView(_posts);
}