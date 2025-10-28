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

  Future<void> _saveLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = {
      "catId": _catId.text.trim(),
      "catName": _catName.text.trim(),
      "timestamp": DateTime.now().toIso8601String()
    };
    await prefs.setString('catNFT', jsonEncode(payload));
    setState(() {
      _status = 'Saved locally at ${DateTime.now().toLocal()}';
    });
  }

  Future<void> _loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('catNFT');
    if (data != null) {
      final decoded = jsonDecode(data);
      setState(() {
        _catId.text = decoded['catId'];
        _catName.text = decoded['catName'];
        _status = 'Loaded locally';
      });
    } else {
      setState(() {
        _status = 'No saved data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final payload = {
      "type": "cat_nft_placeholder",
      "catId": _catId.text.trim(),
      "catName": _catName.text.trim(),
      "version": 2
    }.toString();

    return Scaffold(
      appBar: AppBar(title: const Text('NFT Prep')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('NFT Identity (placeholder)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _catName,
              decoration: const InputDecoration(labelText: 'Cat name', border: OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _catId,
              decoration: const InputDecoration(labelText: 'Cat ID', border: OutlineInputBorder()),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('Preview Card', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset('assets/images/cat_default.png', width: 96, height: 96, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_catName.text.trim(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('ID: ${_catId.text.trim()}'),
                              const SizedBox(height: 4),
                              const Text('Status: Ready for mint (placeholder)'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    QrImageView(data: payload, size: 160),
                    const SizedBox(height: 8),
                    const Text('Scan to read placeholder payload'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('Payload:\n$payload', style: const TextStyle(fontFamily: 'monospace')),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.icon(
                  onPressed: _saveLocal,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Save'),
                ),
                FilledButton.icon(
                  onPressed: _loadLocal,
                  icon: const Icon(Icons.download),
                  label: const Text('Load'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(_status, style: const TextStyle(fontSize: 14, color: Colors.blueGrey)),
          ],
        ),
      ),
    );
  }
}