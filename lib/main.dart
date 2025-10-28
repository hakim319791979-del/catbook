import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/feed_screen.dart';
import 'services/backend.dart';

void main() {
  runApp(const CatGramApp());
}

class CatGramApp extends StatelessWidget {
  const CatGramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Backend>(
      create: (_) => InMemoryBackend(),
      child: MaterialApp(
        title: 'CatGram',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF4E7D96)),
        home: const FeedScreen(),
      ),
    );
  }
}