import 'package:graduation_ap/models/order_item.dart';
import 'package:graduation_ap/models/product.dart';
import 'package:graduation_ap/models/user.dart';

import '../../models/delivery_address.dart';
import '../../models/order.dart';

abstract class OrdersState {}

class CommonState extends OrdersState {}

class ProcessState extends OrdersState {}

class FailedState extends OrdersState {
  final String errorMessage;

  FailedState(this.errorMessage);
}

class SuccessfulLoadedOrdersState extends OrdersState {
  final List<Order> orders;

  SuccessfulLoadedOrdersState(this.orders);
}

class SuccessfulLoadedOrderInfoState extends OrdersState {
  final List<OrderItem> orderItems;
  final List<Product> products;
  final User customer;
  final User? deliveryman;
  final DeliveryAddress deliveryAddress;

  SuccessfulLoadedOrderInfoState(this.orderItems, this.products, this.customer, this.deliveryman, this.deliveryAddress);
}

class SuccessfulUpdatedOrderStatusState extends OrdersState {
  final List<OrderItem> orderItems;
  final List<Product> products;
  final User customer;
  final User? deliveryman;
  final DeliveryAddress deliveryAddress;

  SuccessfulUpdatedOrderStatusState(this.orderItems, this.products, this.customer, this.deliveryman, this.deliveryAddress);
}
