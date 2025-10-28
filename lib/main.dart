import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
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
      home: const CatHomePage(),
    );
  }
}

class CatHomePage extends StatelessWidget {
  const CatHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.brandGradient),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text('CatBook', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          Text('Welcome to CatBook!', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(colors: [cs.primaryContainer, cs.secondaryContainer]),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset('assets/images/cat_default.png', width: 220, height: 220, fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text('Your cat’s NFT-ready profile starts here.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NftScreen())),
                                  icon: const Icon(Icons.qr_code_2),
                                  label: const Text('Prepare NFT / QR'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.pets_outlined),
                                  label: const Text('Explore Cats'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text('v0.2', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}