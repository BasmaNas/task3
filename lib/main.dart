import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task3/screens/log_in.dart';
import 'package:task3/screens/orders.dart';
import 'package:task3/screens/register.dart';
import 'package:task3/screens/reset_password.dart';
import 'screens/log_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'E_commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: LogIn(),
        routes: {
          LogIn.id: (context) => LogIn(),
          Register.id: (context) => Register(),
          ResetPassword.id: (context) => ResetPassword(),
          Orders.id: (context) => Orders(),
        });
  }
}
