import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _name = TextEditingController(text: "New Cat");
  final _caption = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _caption.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _name, decoration: const InputDecoration(labelText: "Cat name")),
            const SizedBox(height: 12),
            TextField(
              controller: _caption,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Caption"),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Saved: ${_name.text} – ${_caption.text}')),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Save locally (phase 2 will persist)'),
            ),
            const SizedBox(height: 8),
            Text('Draft only', style: TextStyle(color: cs.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}