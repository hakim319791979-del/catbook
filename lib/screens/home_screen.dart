import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';
import '../services/local_store.dart';
import '../widgets/post_card.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await LocalStore.loadPosts();
    setState(() => _posts = list.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _load,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: AppTheme.gradient),
              child: const FlexibleSpaceBar(title: Text('CatBook')),
            ),
          ),
          if (_posts.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text("No posts yet. Pull to refresh.")),
            )
          else
            SliverList.separated(
              itemCount: _posts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (_, i) {
                final p = _posts[i];
                return PostCard(
                  catName: p.catName,
                  caption: p.caption,
                  timeAgo: "${p.createdAt.hour}:${p.createdAt.minute.toString().padLeft(2, '0')}",
                  imageAsset: p.imagePath ?? 'assets/images/cat_default.png',
                );
              },
            ),
        ],
      ),
    );
  }
}