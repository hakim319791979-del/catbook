import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/backend.dart';

class PostScreen extends StatefulWidget {
  final String catId;
  const PostScreen({super.key, required this.catId});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _controller = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _saving = true);
    await context.read<Backend>().createPost(catId: widget.catId, caption: text);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Post")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Caption",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                child: Text(_saving ? "Saving..." : "Post"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}