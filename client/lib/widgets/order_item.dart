import 'package:client/features/order_item/order_item_screen.dart';
import 'package:client/repositories/product_repository.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/logs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/order.dart';
import '../models/order_item.dart';
import '../models/product.dart';
import 'loader.dart';

class OrderItems {
  static Widget getOrder(BuildContext externalContext, Order order) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            externalContext,
            MaterialPageRoute(
                builder: (context) => OrderItemScreen(order: order)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${order.id}',
                      style:
                          TS.getOpenSans(24, FontWeight.w700, AppColors.grey),
                    ),
                    Text(
                      order.createdAtFormatted,
                      style:
                          TS.getOpenSans(20, FontWeight.w500, AppColors.grey),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.grey,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Статус:',
                      style:
                          TS.getOpenSans(20, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      order.statusFormatted,
                      style: TS.getOpenSans(
                          20, FontWeight.w500, order.statusColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Тип оплаты:',
                      style:
                          TS.getOpenSans(20, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                      order.paymentFormatted,
                      style:
                          TS.getOpenSans(20, FontWeight.w500, AppColors.black),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColors.grey,
                  thickness: 1,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Итого: ',
                          style: TS.getOpenSans(
                              26, FontWeight.w600, AppColors.black),
                        ),
                        TextSpan(
                          text: '${order.totalPrice} руб',
                          style: TS.getOpenSans(
                              24, FontWeight.w400, AppColors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  static Widget getOrderItem(OrderItem orderItem) {
    return FutureBuilder(
      future: ProductRepository.getProductById(orderItem.productId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Loaders.getAdaptiveLoader());
        } else if (snapshot.error != null) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Product product = snapshot.data!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(
                product.imageUrl,
                scale: 2.5,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Loaders.getAdaptiveLoader(),
                    );
                  }
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${product.name}, ${orderItem.quantity} шт',
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.end,
                      style:
                          TS.getOpenSans(24, FontWeight.w500, AppColors.black),
                    ),
                    Text(
                        '${orderItem.doughFormatted}, ${orderItem.sizeFormatted}',
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.end,
                        style: TS.getOpenSans(
                            22, FontWeight.w500, AppColors.grey)),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text('Нет данных о продукте'));
        }
      },
    );
  }

  static Widget getOrderInfo(Order order, List<OrderItem> orderItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: order.statusColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    order.statusFormatted,
                    textAlign: TextAlign.center,
                    style: TS.getOpenSans(20, FontWeight.w700, AppColors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${order.totalPrice} руб',
                    textAlign: TextAlign.center,
                    style: TS.getOpenSans(20, FontWeight.w700, AppColors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            'Заказанные продукты',
            style: TS.getOpenSans(24, FontWeight.w700, AppColors.black),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemExtent: 130,
              itemCount: orderItems.length,
              itemBuilder: (BuildContext context, int index) {
                return getOrderItem(orderItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
