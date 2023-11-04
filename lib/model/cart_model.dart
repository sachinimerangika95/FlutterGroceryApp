import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/model/product_model.dart';

class CartModel extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;

  // list of items on sale
  // final List _shopItems = const [
  //   // [ itemName, itemPrice, imagePath, color ]
  //   ["Avocado", "4.00", "lib/images/avocado.png", Colors.green],
  //   ["Banana", "2.50", "r", Colors.yellow],
  //   ["Chicken", "12.80", "lib/images/chicken.png", Colors.brown],
  //   ["Water", "1.00", "lib/images/water.png", Colors.blue],
  // ];

  List<ProductModel> _shopItems = [];

  // list of cart items
  List<ProductModel> _cartItems = [];

  CartModel() {
    print('CartModel constructor');
    initializeProducts();
  }

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  void initializeProducts() async {
    _shopItems = await getProducts();
    print(
      '_shopItems $_shopItems',
    );
    notifyListeners();
  }

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i].price);
    }
    return totalPrice.toStringAsFixed(2);
  }

  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _db.collection('products').get();
    return snapshot.docs.map((doc) {
      return ProductModel(
        id: doc.id,
        name: doc.get('name'),
        price: doc.get('price'),
        image: doc.get('image'),
        // Add more fields as per your document structure
      );
    }).toList();
  }
}
