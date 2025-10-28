import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../models/post.dart';
import '../services/local_store.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _name = TextEditingController(text: "New Cat");
  final _caption = TextEditingController();
  File? _image;
  bool _saving = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (picked != null) setState(() => _image = File(picked.path));
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);

    final post = Post(
      id: const Uuid().v4(),
      catName: _name.text.trim(),
      caption: _caption.text.trim(),
      imagePath: _image?.path,
      createdAt: DateTime.now(),
    );

    final existing = await LocalStore.loadPosts();
    existing.add(post);
    await LocalStore.savePosts(existing);

    if (mounted) {
      setState(() => _saving = false);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post saved locally')));
    }
  }

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
            TextField(controller: _caption, maxLines: 4, decoration: const InputDecoration(labelText: "Caption")),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: cs.surfaceContainerHighest.withOpacity(.3),
                  border: Border.all(color: cs.outline),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      )
                    : const Center(child: Text("Tap to pick image")),
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: Text(_saving ? 'Saving...' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}