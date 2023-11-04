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
    notifyListeners();
  }

  // add item to cart
  void addItemToCart(int index) {
    var item = _shopItems[index];
    var cartItem = _cartItems.firstWhere((element) => element.id == item.id,
        orElse: () => ProductModel(name: '', price: '', image: ''));

    if (cartItem.id != null) {
      cartItem.quantity++;
    } else {
      _cartItems.add(item);
    }

    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    } else {
      removeItemFromCart(index);
    }
  }

  void increaseQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i].price) * cartItems[i].quantity;
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
          quantity: 1
          // Add more fields as per your document structure
          );
    }).toList();
  }
}
