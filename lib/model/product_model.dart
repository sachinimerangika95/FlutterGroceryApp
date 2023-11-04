import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String name;
  final String price;
  final String image;

  const ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return ProductModel(
        id: document.id,
        name: data?['name'],
        price: data?['price'],
        image: data?['image']);
  }
}
