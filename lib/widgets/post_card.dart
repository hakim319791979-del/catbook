import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String catName;
  final String caption;
  final String timeAgo;
  final String imageAsset;
  const PostCard({
    super.key,
    required this.catName,
    required this.caption,
    required this.timeAgo,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundColor: cs.primary, child: const Icon(Icons.pets, color: Colors.white)),
            title: Text(catName, style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(timeAgo),
            trailing: Icon(Icons.favorite_border, color: cs.secondary),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            child: Image.asset(imageAsset, height: 200, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(caption),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}