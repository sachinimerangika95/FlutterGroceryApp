import 'package:flutter/material.dart';
import 'package:groceryapp/auth.dart';
import 'package:groceryapp/pages/intro_screen.dart';
import 'package:groceryapp/pages/sign_in_new.dart';

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
            return IntroScreen();
          } else {
            return const SignInScreen();
          }
        });
  }
}
