import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/orders/orders_bloc.dart';
import 'package:graduation_ap/blocs/orders/orders_event.dart';
import 'package:graduation_ap/blocs/orders/orders_state.dart';
import 'package:graduation_ap/styles/app_colors.dart';
import 'package:graduation_ap/styles/ts.dart';
import 'package:graduation_ap/utils/snacks.dart';
import 'package:graduation_ap/widgets/app_bar_style.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../models/order.dart';
import '../../../../models/order_item.dart';
import '../../../../models/product.dart';

class OrderInfoScreen extends StatefulWidget {
  final Order order;
  final OrdersBloc ordersBloc;

  const OrderInfoScreen({
    super.key,
    required this.order,
    required this.ordersBloc,
  });

  @override
  State<OrderInfoScreen> createState() => _OrderInfoScreenState();
}

class _OrderInfoScreenState extends State<OrderInfoScreen> {
  late String _currentStatus;
  final List<String> _orderStatuses = [
    'processing',
    'completed',
    'cancelled',
    'in delivery',
    'deliveried',
  ];

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.order.status;
    widget.ordersBloc.add(GetOrderInfoEvent(widget.order));
  }

  Widget _getOrderItem(OrderItem orderItem, Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          product.imageUrl,
          width: 150,
          height: 150,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.deepOrange,
                  size: 60,
                ),
              );
            }
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Icon(
              Icons.broken_image_outlined,
              color: Colors.deepOrange,
              size: 60,
            );
          },
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Название: ${product.name}',
              style: TS.getOpenSans(18, FontWeight.w400, AppColors.black),
            ),
            Text(
              'Размер: ${orderItem.sizeFormatted}',
              style: TS.getOpenSans(18, FontWeight.w400, AppColors.black),
            ),
            Text(
              'Тесто: ${orderItem.doughFormatted}',
              style: TS.getOpenSans(18, FontWeight.w400, AppColors.black),
            ),
            Text(
              'Количество: ${orderItem.quantity}',
              style: TS.getOpenSans(18, FontWeight.w400, AppColors.black),
            ),
            Text(
              'Топпинги: ${orderItem.toppings}',
              style: TS.getOpenSans(18, FontWeight.w400, AppColors.black),
            ),
            Text(
              'Убранные компоненты: ${orderItem.removedCompositions}',
              style: TS.getOpenSans(18, FontWeight.w400, AppColors.black),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersBloc, OrdersState>(
      bloc: widget.ordersBloc,
      builder: (context, state) {
        if (state is ProcessState) {
          return Scaffold(
            appBar:
                AppBars.getCommonAppBar('Заказ #${widget.order.id}', context),
            body: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                color: AppColors.deepOrange,
                size: 60,
              ),
            ),
          );
        } else if (state is SuccessfulUpdatedOrderStatusState) {
          return Scaffold(
            appBar:
                AppBars.getCommonAppBar('Заказ #${widget.order.id}', context),
            body: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Информация о заказчике:',
                      style:
                          TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Имя: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        state.customer.name,
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Номер телефона: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        state.customer.phoneNumber,
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Адрес доставки: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        state.deliveryAddress.toString(),
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Информация о доставщике:',
                      style:
                          TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  state.deliveryman == null
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Доставщик не назначен',
                            style: TS.getOpenSans(
                                20, FontWeight.w600, AppColors.black),
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Номер телефона: ',
                                  style: TS.getOpenSans(
                                      20, FontWeight.w600, AppColors.black),
                                ),
                                Text(
                                  '${state.deliveryman?.phoneNumber}',
                                  style: TS.getOpenSans(
                                      20, FontWeight.w400, AppColors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Имя: ',
                                  style: TS.getOpenSans(
                                      20, FontWeight.w600, AppColors.black),
                                ),
                                Text(
                                  '${state.deliveryman?.name}',
                                  style: TS.getOpenSans(
                                      20, FontWeight.w400, AppColors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Подробнее о заказе:',
                      style:
                          TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Цена: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        '${widget.order.totalPrice} руб.',
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Тип оплаты: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        widget.order.paymentFormatted,
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Статус заказа: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      DropdownButton<String>(
                        value: _currentStatus,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            _currentStatus = newValue!;
                          });
                          widget.ordersBloc.add(
                            UpdateOrderStatusEvent(
                              widget.order.id,
                              newValue!,
                              state.orderItems,
                              state.products,
                              state.customer,
                              state.deliveryman,
                              state.deliveryAddress,
                            ),
                          );
                        },
                        items: _orderStatuses
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.orderItems.length,
                      itemExtent: 240,
                      itemBuilder: (context, index) {
                        return _getOrderItem(
                            state.orderItems[index],
                            state.products.firstWhere((product) =>
                                product.id ==
                                state.orderItems[index].productId));
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                ],
              ),
            ),
          );
        } else if (state is SuccessfulLoadedOrderInfoState) {
          return Scaffold(
            appBar:
            AppBars.getCommonAppBar('Заказ #${widget.order.id}', context),
            body: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Информация о заказчике:',
                      style:
                      TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Имя: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        state.customer.name,
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Номер телефона: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        state.customer.phoneNumber,
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Адрес доставки: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        state.deliveryAddress.toString(),
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Информация о доставщике:',
                      style:
                      TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  state.deliveryman == null
                      ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Доставщик не назначен',
                      style: TS.getOpenSans(
                          20, FontWeight.w600, AppColors.black),
                    ),
                  )
                      : Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Номер телефона: ',
                            style: TS.getOpenSans(
                                20, FontWeight.w600, AppColors.black),
                          ),
                          Text(
                            '${state.deliveryman?.phoneNumber}',
                            style: TS.getOpenSans(
                                20, FontWeight.w400, AppColors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Имя: ',
                            style: TS.getOpenSans(
                                20, FontWeight.w600, AppColors.black),
                          ),
                          Text(
                            '${state.deliveryman?.name}',
                            style: TS.getOpenSans(
                                20, FontWeight.w400, AppColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Подробнее о заказе:',
                      style:
                      TS.getOpenSans(24, FontWeight.w600, AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Цена: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        '${widget.order.totalPrice} руб.',
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Тип оплаты: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      Text(
                        widget.order.paymentFormatted,
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Статус заказа: ',
                        style: TS.getOpenSans(
                            20, FontWeight.w600, AppColors.black),
                      ),
                      DropdownButton<String>(
                        value: _currentStatus,
                        icon: const Icon(Icons.arrow_drop_down),
                        style: TS.getOpenSans(
                            20, FontWeight.w400, AppColors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            _currentStatus = newValue!;
                          });
                          widget.ordersBloc.add(
                            UpdateOrderStatusEvent(
                              widget.order.id,
                              newValue!,
                              state.orderItems,
                              state.products,
                              state.customer,
                              state.deliveryman,
                              state.deliveryAddress,
                            ),
                          );
                        },
                        items: _orderStatuses
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.orderItems.length,
                      itemExtent: 240,
                      itemBuilder: (context, index) {
                        return _getOrderItem(
                            state.orderItems[index],
                            state.products.firstWhere((product) =>
                            product.id ==
                                state.orderItems[index].productId));
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBars.getCommonAppBar('Заказ #${widget.order.id}', context),
          body: const SizedBox(),
        );
      },
      listener: (context, state) {
        if (state is SuccessfulUpdatedOrderStatusState) {
          Snacks.success(context, 'Статус обновлен успешно');
        }
      },
    );
  }
}
