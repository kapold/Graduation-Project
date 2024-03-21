import 'package:client/models/order_item.dart';

abstract class CartEvent {}

class GetCartEvent extends CartEvent {}

class OrderCartEvent extends CartEvent {
  final List<OrderItem> orderItems;

  OrderCartEvent(this.orderItems);
}