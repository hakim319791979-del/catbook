import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/nft_screen.dart';

void main() => runApp(const CatBookApp());

class CatBookApp extends StatelessWidget {
  const CatBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _index = 0;
  final _screens = const [HomeScreen(), NewPostScreen(), NftScreen()];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: cs.surface,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'New'),
          NavigationDestination(icon: Icon(Icons.qr_code_2), selectedIcon: Icon(Icons.qr_code), label: 'NFT'),
        ],
      ),
    );
  }
}