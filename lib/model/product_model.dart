import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? id;
  final String name;
  final String price;
  final String image;
  int quantity;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return ProductModel(
        id: document.id,
        name: data?['name'],
        price: data?['price'],
        image: data?['image'],
        quantity: 1);
  }

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, image: $image, quantity: $quantity}';
  }
}
