import 'package:client/models/order_item.dart';
import 'package:flutter/material.dart';

class CartItems {
  static Widget getCartItem(OrderItem product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(product.toString()),
    );
  }
}