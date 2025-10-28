import 'package:flutter/material.dart';

void main() => runApp(const CatBookApp());

class CatBookApp extends StatelessWidget {
  const CatBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatBook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4E7D96),
      ),
      home: const CatHomePage(),
    );
  }
}

class CatHomePage extends StatelessWidget {
  const CatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CatBook')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to CatBook!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/cat_default.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'This is your cat’s default NFT placeholder.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}