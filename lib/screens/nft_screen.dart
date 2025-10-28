import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NftScreen extends StatefulWidget {
  const NftScreen({super.key});

  @override
  State<NftScreen> createState() => _NftScreenState();
}

class _NftScreenState extends State<NftScreen> {
  final _catName = TextEditingController(text: 'Zubair');
  final _catId = TextEditingController(text: 'c1');
  String _status = '';

  @override
  void dispose() {
    _catName.dispose();
    _catId.dispose();
    super.dispose();
  }

  Map<String, dynamic> _payload() => {
        "type": "cat_nft_placeholder",
        "catId": _catId.text.trim(),
        "catName": _catName.text.trim(),
        "version": 2
      };

  Future<void> _saveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('catNFT', jsonEncode(_payload()));
    setState(() => _status = 'Saved locally');
  }

  Future<void> _loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('catNFT');
    if (data == null) {
      setState(() => _status = 'No saved data');
      return;
    }
    final decoded = jsonDecode(data);
    _catId.text = decoded['catId'] ?? _catId.text;
    _catName.text = decoded['catName'] ?? _catName.text;
    setState(() => _status = 'Loaded locally');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final payloadStr = _payload().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NFT Prep'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF6C5CE7), Color(0xFF00D2D3)]),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(colors: [cs.primaryContainer, cs.secondaryContainer]),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/images/cat_default.png', fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NFT Identity', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 6),
                            Text('Prepare and preview your cat NFT payload.', style: TextStyle(color: cs.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _catName,
                    decoration: const InputDecoration(labelText: 'Cat name'),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _catId,
                    decoration: const InputDecoration(labelText: 'Cat ID'),
                    onChanged: (_) => setState(() {}),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  QrImageView(data: payloadStr, size: 180),
                  const SizedBox(height: 8),
                  Text('Scan this QR to read the NFT placeholder', style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payload', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest.withOpacity(.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(payloadStr, style: const TextStyle(fontFamily: 'monospace')),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _saveLocal,
                          icon: const Icon(Icons.save_alt),
                          label: const Text('Save'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _loadLocal,
                          icon: const Icon(Icons.download),
                          label: const Text('Load'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(_status, style: TextStyle(color: cs.primary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}