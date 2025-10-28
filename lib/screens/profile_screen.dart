import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cat.dart';
import '../services/backend.dart';

class ProfileScreen extends StatelessWidget {
  final String catId;
  const ProfileScreen({super.key, required this.catId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Cat>(
      future: context.read<Backend>().getCat(catId),
      builder: (context, snap) {
        final title = snap.data?.name ?? "Cat";
        return Scaffold(
          appBar: AppBar(title: Text("$title Profile")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(radius: 40),
                const SizedBox(height: 12),
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const Text("Future: NFT badge here"),
              ],
            ),
          ),
        );
      },
    );
  }
}