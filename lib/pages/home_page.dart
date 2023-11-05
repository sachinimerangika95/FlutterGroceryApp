import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/auth.dart';
import 'package:groceryapp/pages/sign_in_new.dart';
import 'package:provider/provider.dart';

import '../components/grocery_item_tile.dart';
import '../model/cart_model.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut().then((value) => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SignInScreen();
              },
            ),
          )
        });
  }

  Widget _logOutButton() {
    return GestureDetector(
        onTap: signOut,
        child: Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.logout,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 1,
        title: Row(
          children: <Widget>[
            const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                user?.email ?? '',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          user?.email != null
              ? GestureDetector(
                  child: _logOutButton(),
                )
              : GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignInScreen();
                      },
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Container(
                      child: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
        ],
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CartPage();
                      },
                    ),
                  ),
              child: Consumer<CartModel>(builder: (context, value, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    const Icon(Icons.shopping_bag,
                        size: 35.0), // increase the size as needed
                    Positioned(
                      child: Padding(
                        padding: EdgeInsets.only(top: 11.0),
                        child: Text(
                          value.cartItems.length > 0
                              ? value.cartItems.length.toString()
                              : '', // replace with your quantity variable
                          style: const TextStyle(
                            fontSize: 12.0, // increase the size as needed
                            fontWeight: FontWeight.w900,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          // good morning bro
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text('Good morning,'),
          ),

          const SizedBox(height: 2),

          // Let's order fresh items for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Let's order fresh items for you",
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // recent orders -> show last 3
          Expanded(
            child: Consumer<CartModel>(
              builder: (context, value, child) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: value.shopItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                      itemName: value.shopItems[index].name,
                      itemPrice: value.shopItems[index].price,
                      imagePath: value.shopItems[index].image,
                      color: Colors.green,
                      // color: value.shopItems[index][3],
                      onPressed: () =>
                          Provider.of<CartModel>(context, listen: false)
                              .addItemToCart(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
