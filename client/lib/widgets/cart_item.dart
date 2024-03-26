import 'package:client/features/cart/bloc/cart_bloc.dart';
import 'package:client/features/cart/bloc/cart_event.dart';
import 'package:client/models/order.dart';
import 'package:client/models/order_item.dart';
import 'package:client/models/product.dart';
import 'package:client/styles/app_colors.dart';
import 'package:client/styles/ts.dart';
import 'package:client/utils/local_db.dart';
import 'package:client/utils/profile_data.dart';
import 'package:client/widgets/loader.dart';
import 'package:flutter/material.dart';

class CartItems {
  static double getTotalPrice(List<OrderItem> orderItems) {
    return orderItems.fold(0, (total, item) => total + item.price * item.quantity);
  }

  static Widget getCartItem(OrderItem orderItem, CartBloc bloc) {
    Product product = AppData.products.firstWhere((p) => p.id == orderItem.productId);
    String itemSize = '', itemDough = '';
    if (orderItem.size == 'small') {
      itemSize = 'Маленькая 25 см';
    }
    else if (orderItem.size == 'medium') {
      itemSize = 'Средняя 30 см';
    }
    else if (orderItem.size == 'large') {
      itemSize = 'Большая 35 см';
    }

    if (orderItem.dough == 'traditional') {
      itemDough =  'Традиционное';
    }
    else if (orderItem.dough == 'thin') {
      itemDough = 'Тонкое';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.name,
                    style: TS.getOpenSans(20, FontWeight.w500, AppColors.black),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      '$itemSize, $itemDough',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.clip,
                      style: TS.getOpenSans(16, FontWeight.w500, AppColors.grey),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(orderItem.quantity * orderItem.price).toStringAsFixed(2)} руб',
                style: TS.getOpenSans(20, FontWeight.w700, AppColors.black),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Container(
                  height: 36,
                  width: 120,
                  color: AppColors.lightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (orderItem.quantity == 1) {
                            LocalDb().deleteOrderItem(orderItem);
                            bloc.add(GetCartEvent());
                            return;
                          }

                          orderItem.quantity -= 1;
                          LocalDb().updateOrderItem(orderItem);
                          bloc.add(GetCartEvent());
                        },
                        color: AppColors.white,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        orderItem.quantity.toString(),
                        style: TS.getOpenSans(20, FontWeight.w500, AppColors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          orderItem.quantity += 1;
                          LocalDb().updateOrderItem(orderItem).then((_) {
                            bloc.add(GetCartEvent());
                          });
                        },
                        color: AppColors.white,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}