import 'package:client/models/order.dart';
import 'package:client/repositories/order_repository.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/widgets/app_bar_style.dart';
import 'package:flutter/material.dart';

import '../../widgets/loader.dart';
import '../../widgets/order_item.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.getCommonAppBar('История заказов', context),
      body: FutureBuilder(
        future: OrderRepository.getOrdersByUserId(AppData.user.id),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Loaders.getAdaptiveLoader());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Order> orders = snapshot.data!;
            return ListView.builder(
              itemExtent: 210,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderItems.getOrder(context, orders[index]);
              },
            );
          } else {
            return const Center(child: Text('Нет данных о заказанных товарах'));
          }
        },
      ),
    );
  }
}
