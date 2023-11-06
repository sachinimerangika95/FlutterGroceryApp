import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/auth.dart';
import 'package:groceryapp/components/my_button.dart';
import 'package:groceryapp/components/my_textbutton.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/pages/onboarding.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Onboarding();
          },
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage:
        e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
            child: Column(
          children: [
            const Spacer(),
            Text(
              "Hello, Ready to Get Started?",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 24,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Please sign in with your Email and Password",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.displaySmall,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MytextField(
              controller: _controllerEmail,
              hintText: 'Enter your email',
              obscureText: false,
              labelText: "Email",
            ),
            const SizedBox(
              height: 30,
            ),
            MytextField(
              controller: _controllerPassword,
              hintText: 'Enter your password',
              obscureText: true,
              labelText: "Password",
            ),
            const SizedBox(
              height: 25,
            ),
            // const MyTextButton(
            //   labelText: "forgot password?",
            //   pageRoute: 'forgot',
            // ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              hintText: 'sign in',
              onTap: () {
                signInWithEmailAndPassword();
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or ',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a Member',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const MyTextButton(
                    labelText: "Register now",
                    pageRoute: 'register',
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        )),
      ),
    );
  }
}
