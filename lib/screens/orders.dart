import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  static const id = "Orders";

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("orders"),
      ),
    );
  }
}
