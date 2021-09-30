import 'dart:async';

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task3/screens/orders.dart';
import 'package:task3/screens/register.dart';
import 'package:task3/screens/reset_password.dart';

class LogIn extends StatefulWidget {
  static const id = 'LogIn';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  StreamSubscription<User> l;
  @override
  void initState() {
    super.initState();
    l = FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == !null) {
        Navigator.pushReplacementNamed(context, Orders.id);
        print('User is signed in!');
      }
    });
  }

  void dispose() {
    super.dispose();
    l.cancel();

    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              // child: Container(//image ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter Your Email",
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Enter Your Password",
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }
                },
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.deepPurple,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ))),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ResetPassword.id);
              },
              child: Text(
                "Forget Paasword",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Register.id);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepPurpleAccent),
                    ))
              ],
            ),
          ],
        ),
      )),
    );
  }
}
