import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? id;
  final String total;
  final String userId;
  final List<dynamic> products;

  OrderModel({
    this.id,
    required this.total,
    required this.userId,
    required this.products,
  });

  factory OrderModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return OrderModel(
      id: document.id,
      total: data?['total'],
      userId: data?['userId'],
      products: data?['products'],
    );
  }

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'total': total,
      'userId': userId,
      'products': products,
    };
  }

  @override
  String toString() {
    return 'Order{id: $id, total: $total, userId: $userId}, products: $products';
  }
}
