import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceryapp/auth.dart';
import 'package:groceryapp/components/my_button.dart';
import 'package:groceryapp/components/my_textbutton.dart';
import 'package:groceryapp/components/my_textfield.dart';
import 'package:groceryapp/pages/onboarding.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _db = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final passwordController = TextEditingController();

  // void signInUser() async {
  //   if (nameController.text != "" &&
  //       emailController.text != "" &&
  //       sexController.text != "" &&
  //       ageController.text != "" &&
  //       passwordController != "") {
  //     print('Well Done.');
  //   } else {
  //     print('Please fill out all the information');
  //   }
  // }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final userCredential = await Auth().createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await _db.collection('users').doc(userCredential.user?.uid).set({
        'name': nameController.text,
        'age': ageController.text,
      });
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Form(
            child: Column(
          children: [
            const Spacer(),
            Text(
              "Welcome to our community!",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "To get started, please provide your information and create an account.",
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MytextField(
              controller: nameController,
              hintText: 'Enter your name',
              obscureText: false,
              labelText: "Name",
            ),
            const SizedBox(
              height: 30,
            ),
            MytextField(
              controller: emailController,
              hintText: 'Enter your Email',
              obscureText: false,
              labelText: "Email",
            ),
            const SizedBox(
              height: 30,
            ),
            MytextField(
              controller: ageController,
              hintText: 'Enter your Age',
              obscureText: false,
              labelText: "Age",
            ),
            const SizedBox(
              height: 30,
            ),
            MytextField(
              controller: passwordController,
              hintText: 'Enter a password',
              obscureText: true,
              labelText: "password",
            ),
            const SizedBox(
              height: 40,
            ),
            MyButton(
              hintText: 'sign up',
              onTap: () {
                createUserWithEmailAndPassword();
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
                    'Have an account',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displaySmall,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const MyTextButton(
                    labelText: "Sign in",
                    pageRoute: 'login',
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
