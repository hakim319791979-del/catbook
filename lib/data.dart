import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 1)
class Cat extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String? avatarPath;
  // NFT-ready fields
  @HiveField(3) String? nftTokenId;
  @HiveField(4) String? nftChain;
  Cat({required this.id, required this.name, this.avatarPath, this.nftTokenId, this.nftChain});
}

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String catId;
  @HiveField(2) String text;
  @HiveField(3) String? imagePath;
  @HiveField(4) DateTime createdAt;
  Post({required this.id, required this.catId, required this.text, this.imagePath, required this.createdAt});
}