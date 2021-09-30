import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task3/screens/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';

class Register extends StatefulWidget {
  static const id = 'Register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final shopNameController = TextEditingController();
  final shopAddressController = TextEditingController();
  Future register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      if (mounted) {
        setState(() {
          adminId = userCredential.user.uid;
        });
      }
      await uploadUserData().then(() {
        Navigator.pushReplacementNamed(context, LogIn.id);
      });
      print("Sucessful Sign up");
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      shopNameController.clear();
      shopAddressController.clear();
      return;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        setState(() {
          print('weak password');
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          print('email already in use');
        });
      }
    } catch (e) {
      print(e);
    }
  }

  uploadUserData() {
    adminsCollection.doc(adminId).set({
      "name": nameController.text,
      "email": emailController.text,
      "id": adminId,
      "shopName": shopNameController,
      "shopAddress": shopAddressController,
    });
    print('Account Added succefully');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (mounted) {
      nameController.dispose();
      emailController.dispose();
      passwordController.dispose();
      shopAddressController.dispose();
      shopNameController.dispose();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              color: Colors.deepPurple,
              onPressed: () {
                Navigator.pushReplacementNamed(context, LogIn.id);
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              )),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Enter Your Name",
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: Icon(Icons.person),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Enter Your Email",
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: Icon(Icons.email),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: shopNameController,
                decoration: InputDecoration(
                    labelText: "Enter Your Shop's name",
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: Icon(Icons.add),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: shopAddressController,
                decoration: InputDecoration(
                    labelText: "Enter Your Shop's address",
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: Icon(Icons.maps_home_work),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              FlatButton(
                  onPressed: () {
                    register();
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
                          Icon(
                            Icons.check,
                            size: 30,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
