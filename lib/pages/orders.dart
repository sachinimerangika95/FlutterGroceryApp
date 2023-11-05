import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/auth.dart';
import 'package:groceryapp/model/cart_model.dart';
import 'package:groceryapp/model/order_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(OrdersList());
}

class Order {
  final String id;
  final List<Product> products;
  final String total;
  final String userId;

  Order({
    required this.id,
    required this.products,
    required this.total,
    required this.userId,
  });
}

class Product {
  final String id;
  final String image;
  final String name;
  final String price;
  final int quantity;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class OrdersList extends StatelessWidget {
  OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;
  final List<OrderModel>? orders = CartModel().orders;

  List<Order> orders_old = [
    Order(
      id: 'NhglMZPqhVSBlqYEo7hk',
      products: [
        Product(
          id: 'BGSun1436y3QByPLg7mM',
          image: 'lib/images/avocado.png',
          name: 'Avocado',
          price: '4',
          quantity: 2,
        ),
        Product(
          id: '8uuu4xQeFIl657tDkF9H',
          image: 'lib/images/chicken.png',
          name: 'Chicken',
          price: '12.8',
          quantity: 1,
        ),
      ],
      total: '20.80',
      userId: 'l6qcfTskHFUwf1MdSO0LnBlum6B3',
    ),
    Order(
      id: 'NhglMZPqhVSBlqYEo7hk',
      products: [
        Product(
          id: 'BGSun1436y3QByPLg7mM',
          image: 'lib/images/avocado.png',
          name: 'Avocado',
          price: '4',
          quantity: 2,
        ),
        Product(
          id: '8uuu4xQeFIl657tDkF9H',
          image: 'lib/images/chicken.png',
          name: 'Chicken',
          price: '12.8',
          quantity: 1,
        ),
      ],
      total: '20.80',
      userId: 'l6qcfTskHFUwf1MdSO0LnBlum6B3',
    ),
    // Add more orders here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders',
          style: TextStyle(
            color: Colors.black54, // Change this to your desired color
          ),
        ),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          print('orders');
          print(value.orders);
          // List<OrderModel> filteredOrders = value.orders;
          List<OrderModel> filteredOrders =
              value.orders.where((item) => item.userId == user?.uid).toList();

          print('filteredOrders');
          print(filteredOrders);

          return ListView.builder(
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text('Order Number ${index + 1}'),
                children: [
                  Column(
                    children:
                        filteredOrders[index].products.map<Widget>((product) {
                      return ListTile(
                        leading: Image.asset(
                          product['image'],
                          height: 36,
                        ),
                        title: Text(product['name']),
                        subtitle: Text(
                            'Quantity: ${product['quantity']}    Price: \$${product['price']}'),
                      );
                    }).toList(),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                        Text('\$${value.orders[index].total}',
                            style: TextStyle(fontSize: 16.0)),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
