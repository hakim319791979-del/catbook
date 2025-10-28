import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      ("Mishmish", "Morning sunbath on the balcony.", "2h", "assets/images/cat_default.png"),
      ("Zubair", "Chasing a laser dot like a pro!", "5h", "assets/images/cat_default.png"),
      ("Lulu", "Power nap achieved.", "1d", "assets/images/cat_default.png"),
    ];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 140,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: AppTheme.gradient),
            child: const FlexibleSpaceBar(
              title: Text('CatBook'),
              centerTitle: true,
            ),
          ),
        ),
        SliverList.separated(
          itemCount: posts.length,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemBuilder: (_, i) {
            final p = posts[i];
            return PostCard(catName: p.$1, caption: p.$2, timeAgo: p.$3, imageAsset: p.$4);
          },
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}