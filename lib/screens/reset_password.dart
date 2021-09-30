import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'log_in.dart';

class ResetPassword extends StatefulWidget {
  static const id = 'ResetPassword';

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final resetPasscontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, LogIn.id);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: resetPasscontroller,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Enter Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 39),
                child: FlatButton(
                    onPressed: () async {
                      try {
                        await auth
                            .sendPasswordResetEmail(
                                email: resetPasscontroller.text)
                            .then((value) {
                          print('Check your email');
                        });
                        Navigator.pushReplacementNamed(context, LogIn.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  content: Text("That email not found.",
                                      style: TextStyle(color: Colors.white)),
                                );
                              });
                          print('No user found for that email.');
                        }
                      }
                    },
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.deepPurpleAccent,
                        ),
                        child: Center(
                            child: Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
