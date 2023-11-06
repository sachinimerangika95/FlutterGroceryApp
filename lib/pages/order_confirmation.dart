import 'package:flutter/material.dart';
import 'package:groceryapp/pages/home_page.dart';

void main() {
  runApp(OrderConfirmationPage());
}

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100.0,
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Your order has been placed successfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepOrange, // Set the background color here
                ),
                child: Text('Continue Shopping'),
                onPressed: () {
                  // Navigate back to home page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
