import 'dart:async';

import 'package:client/features/orders/bloc/order_bloc.dart';
import 'package:client/features/orders/bloc/order_state.dart';
import 'package:client/utils/snacks.dart';
import 'package:client/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/app_colors.dart';
import '../../styles/ts.dart';
import '../../utils/profile_data.dart';
import '../../widgets/loader.dart';
import 'bloc/order_event.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen(this.externalContext, this.orderBloc, {super.key});

  BuildContext externalContext;
  OrderBloc orderBloc;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState(externalContext, orderBloc);
}

class _OrdersScreenState extends State<OrdersScreen> {
  _OrdersScreenState(this.externalContext, this.orderBloc);

  BuildContext externalContext;
  OrderBloc orderBloc;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      orderBloc.add(GetOrdersEvent(AppData.user.id));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      bloc: orderBloc,
      builder: (context, state) {
        if (state is LoadingOrdersState) {
          orderBloc.add(GetOrdersEvent(AppData.user.id));
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Loaders.getAdaptiveLoader(),
              ),
            ),
          );
        }
        if (state is SuccessfulLoadedState) {
          final DateTime lastDay = DateTime.now().subtract(const Duration(days: 1));
          final recentOrders = state.orders.where((order) => order.createdAt.isAfter(lastDay)).toList();
          if (recentOrders.isEmpty) {
            return Scaffold(
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset('assets/images/delivery-icon.png'),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Сделайте заказ, чтобы увидеть его прогресс',
                              textAlign: TextAlign.center,
                              style: TS.getOpenSans(
                                  18, FontWeight.w300, AppColors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Text(
                      'Последние заказы',
                      style: TS.getOpenSans(26, FontWeight.w500, AppColors.deepOrange),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemExtent: 210,
                        itemCount: recentOrders.length,
                        itemBuilder: (context, index) {
                          return OrderItems.getOrder(externalContext, recentOrders[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(
                'Произошла ошибка',
                style: TS.getOpenSans(20, FontWeight.w500, AppColors.black),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is FailedLoadedState) {
          Snacks.failed(context, 'Ошибка загрузки заказов');
        }
      },
    );
  }
}
