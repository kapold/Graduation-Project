import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen(this.externalContext, {super.key});

  BuildContext externalContext;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState(externalContext);
}

class _OrdersScreenState extends State<OrdersScreen> {
  _OrdersScreenState(this.externalContext);
  BuildContext externalContext;

  List<String> orders = [];

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
          body: Expanded(
              child: Center(
                  child: Text('No active deliveries')
              )
          )
        )
    );
  }
}
