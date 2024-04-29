import 'package:flutter/material.dart';

import '../../../../blocs/menu/menu_bloc.dart';
import '../../../../blocs/orders/orders_bloc.dart';

class OrdersScreen extends StatefulWidget {
  final MenuBloc menuBloc;
  final OrdersBloc ordersBloc;

  const OrdersScreen({
    super.key,
    required this.menuBloc,
    required this.ordersBloc,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Orders'),
      ),
    );
  }
}
