import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../services/backend.dart';
import '../widgets/post_card.dart';
import 'post_screen.dart';
import 'profile_screen.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<Post>> _future;

  @override
  void initState() {
    super.initState();
    _future = context.read<Backend>().fetchFeed();
  }

  Future<void> _refresh() async {
    final data = await context.read<Backend>().fetchFeed();
    setState(() {
      _future = Future.value(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CatGram Feed"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen(catId: "c1"))),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text("Error: ${snap.error}"));
          }
          final posts = snap.data ?? [];
          if (posts.isEmpty) {
            return const Center(child: Text("No posts yet."));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, i) => FutureBuilder(
                future: context.read<Backend>().getCat(posts[i].catId),
                builder: (context, catSnap) {
                  final name = catSnap.data?.name ?? "...";
                  return PostCard(post: posts[i], catName: name);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const PostScreen(catId: "c1")));
          await _refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}