import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/orders/orders_event.dart';
import 'package:graduation_ap/blocs/orders/orders_state.dart';
import 'package:graduation_ap/styles/ts.dart';
import 'package:graduation_ap/ui/admin_panel/screens/order_info/order_info_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../blocs/menu/menu_bloc.dart';
import '../../../../blocs/orders/orders_bloc.dart';
import '../../../../models/order.dart';
import '../../../../styles/app_colors.dart';
import '../../../../widgets/input_decorations.dart';

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
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    widget.ordersBloc.add(GetAllOrdersEvent());
    _searchController.addListener(() {
      widget.ordersBloc.add(GetAllOrdersEvent());
    });
  }

  Widget _getOrderItem(Order order) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OrderInfoScreen(order: order, ordersBloc: widget.ordersBloc,),
            ),
          );
          widget.ordersBloc.add(GetAllOrdersEvent());
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.grey,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Заказ #${order.id}',
                  style: TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Статус: ',
                    style: TS.getOpenSans(20, FontWeight.w600, AppColors.black),
                  ),
                  Text(
                    order.statusFormatted,
                    style: TS.getOpenSans(20, FontWeight.w400, order.statusColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Цена: ',
                    style: TS.getOpenSans(20, FontWeight.w600, AppColors.black),
                  ),
                  Text(
                    '${order.totalPrice} руб.',
                    style: TS.getOpenSans(20, FontWeight.w400, AppColors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Тип оплаты: ',
                    style: TS.getOpenSans(20, FontWeight.w600, AppColors.black),
                  ),
                  Text(
                    order.paymentFormatted,
                    style: TS.getOpenSans(20, FontWeight.w400, AppColors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Дата заказа: ',
                    style: TS.getOpenSans(20, FontWeight.w600, AppColors.black),
                  ),
                  Text(
                    order.createdAtFormatted,
                    style: TS.getOpenSans(20, FontWeight.w400, AppColors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Дата последнего обновления: ',
                    style: TS.getOpenSans(20, FontWeight.w600, AppColors.black),
                  ),
                  Text(
                    order.updatedAtFormatted,
                    style: TS.getOpenSans(20, FontWeight.w400, AppColors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      bloc: widget.ordersBloc,
      builder: (context, state) {
        if (state is SuccessfulLoadedOrdersState) {
          List<Order> filteredOrders = state.orders.where((order) {
            return order.id.toString().contains(_searchController.text);
          }).toList();

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    maxLines: null,
                    decoration: InputDecorations.getSearch(
                      'Поиск',
                      'Введите номер заказа',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredOrders.length,
                      itemExtent: 250,
                      itemBuilder: (context, index) {
                        return _getOrderItem(filteredOrders[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  maxLines: null,
                  decoration: InputDecorations.getSearch(
                    'Поиск',
                    'Введите номер заказа',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
