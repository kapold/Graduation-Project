import 'package:client/models/order.dart';
import 'package:client/repositories/order_item_repository.dart';
import 'package:client/widgets/loader.dart';
import 'package:client/widgets/order_item.dart';
import 'package:flutter/material.dart';

import '../../models/order_item.dart';
import '../../widgets/app_bar_style.dart';

class OrderItemScreen extends StatefulWidget {
  const OrderItemScreen({super.key, required this.order});

  final Order order;

  @override
  State<OrderItemScreen> createState() => _OrderItemScreenState();
}

class _OrderItemScreenState extends State<OrderItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.getCommonAppBar('Заказ #${widget.order.id}', context),
      body: FutureBuilder(
        future: OrderItemRepository.getOrderItemsByOrderId(widget.order.id),
        builder: (BuildContext context, AsyncSnapshot<List<OrderItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Loaders.getAdaptiveLoader());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<OrderItem> orderItems = snapshot.data!;
            return OrderItems.getOrderInfo(widget.order, orderItems, context);
          } else {
            return const Center(child: Text('Нет данных о заказанных товарах'));
          }
        },
      ),
    );
  }
}
