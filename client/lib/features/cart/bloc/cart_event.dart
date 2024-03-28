import 'package:client/models/order_item.dart';

abstract class CartEvent {}

class GetCartEvent extends CartEvent {}

class OrderCartEvent extends CartEvent {
  final int userId;
  final String paymentType;
  final double totalPrice;
  final List<OrderItem> orderItems;

  OrderCartEvent(this.userId, this.paymentType, this.totalPrice, this.orderItems);
}