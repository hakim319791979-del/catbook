import 'package:flutter/material.dart';

void main() => runApp(const CatBookApp());

class CatBookApp extends StatelessWidget {
  const CatBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatBook',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CatBook')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.pets, size: 96),
            SizedBox(height: 16),
            Text('مرحبًا من CatBook'),
          ],
        ),
      ),
    );
  }
}