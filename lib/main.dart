import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CatAdapter());
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<Cat>('cats');
  await Hive.openBox<Post>('posts');
  runApp(const CatBookApp());
}

class CatBookApp extends StatelessWidget {
  const CatBookApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatBook',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget { const HomePage({super.key}); @override State<HomePage> createState()=>_HomePageState(); }
class _HomePageState extends State<HomePage> {
  final cats = Hive.box<Cat>('cats');
  final posts = Hive.box<Post>('posts');
  final uuid = const Uuid();

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CatBook')),
      body: ValueListenableBuilder(
        valueListenable: posts.listenable(),
        builder: (_, Box<Post> box, __) {
          final items = box.values.toList()..sort((a,b)=>b.createdAt.compareTo(a.createdAt));
          if (items.isEmpty) return const Center(child: Text('لا توجد يوميات بعد'));
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) {
              final p = items[i];
              final cat = cats.values.firstWhere((c)=>c.id==p.catId, orElse: ()=>Cat(id:'?',name:'قطة غير معروفة'));
              return Card(
                margin: const EdgeInsets.all(12),
                child: ListTile(
                  leading: cat.avatarPath==null? const CircleAvatar(child: Icon(Icons.pets))
                    : CircleAvatar(backgroundImage: FileImage(File(cat.avatarPath!))),
                  title: Text(cat.name),
                  subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(p.text),
                    if (p.imagePath!=null) Padding(padding: const EdgeInsets.only(top:8), child: Image.file(File(p.imagePath!))),
                    Text(p.createdAt.toLocal().toString().split('.').first, style: const TextStyle(fontSize:12)),
                  ]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: 'newPost', onPressed: _newPost, label: const Text('يومية جديدة'), icon: const Icon(Icons.edit)),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'newCat', onPressed: _newCat, label: const Text('إضافة قطة'), icon: const Icon(Icons.pets)),
        ],
      ),
    );
  }

  Future<void> _newCat() async {
    final nameCtl = TextEditingController();
    String? imgPath;
    await showDialog(context: context, builder: (_) {
      return AlertDialog(
        title: const Text('قطة جديدة'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameCtl, decoration: const InputDecoration(labelText: 'الاسم')),
          const SizedBox(height: 8),
          Row(children: [
            ElevatedButton(onPressed: () async {
              final x = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (x!=null) { imgPath = x.path; }
            }, child: const Text('اختر صورة'))
          ])
        ]),
        actions: [
          TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: () {
            final id = const Uuid().v4();
            Hive.box<Cat>('cats').add(Cat(id:id, name:nameCtl.text.trim(), avatarPath: imgPath));
            Navigator.pop(context);
          }, child: const Text('حفظ')),
        ],
      );
    });
    setState((){});
  }

  Future<void> _newPost() async {
    final catsBox = Hive.box<Cat>('cats');
    if (catsBox.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('أضف قطة أولًا'))); return; }
    Cat selected = catsBox.values.first;
    final textCtl = TextEditingController();
    String? imgPath;
    await showDialog(context: context, builder: (_) {
      return StatefulBuilder(builder: (ctx, setS) {
        return AlertDialog(
          title: const Text('يومية جديدة'),
          content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
            DropdownButton<Cat>(value: selected, isExpanded: true, items: catsBox.values.map((c)=>
              DropdownMenuItem(value: c, child: Text(c.name))).toList(),
              onChanged: (v)=> setS(()=> selected = v!)),
            TextField(controller: textCtl, decoration: const InputDecoration(labelText: 'النص')),
            const SizedBox(height: 8),
            Row(children: [
              ElevatedButton(onPressed: () async {
                final x = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (x!=null) { setS(()=> imgPath = x.path); }
              }, child: const Text('صورة اختيارية'))
            ]),
          ])),
          actions: [
            TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('إلغاء')),
            ElevatedButton(onPressed: () {
              final id = const Uuid().v4();
              Hive.box<Post>('posts').add(Post(id:id, catId:selected.id, text:textCtl.text.trim(), imagePath: imgPath, createdAt: DateTime.now()));
              Navigator.pop(context);
            }, child: const Text('نشر')),
          ],
        );
      });
    });
    setState((){});
  }
}