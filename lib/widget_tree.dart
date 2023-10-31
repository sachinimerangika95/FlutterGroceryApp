import 'package:flutter/material.dart';
import 'package:groceryapp/auth.dart';
import 'package:groceryapp/pages/auth/sign_in.dart';
import 'package:groceryapp/pages/auth/sign_up.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SignInPage();
          } else {
            return const LoginPage();
          }
        });
  }
}
