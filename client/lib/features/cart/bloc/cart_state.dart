import '../../../models/order_item.dart';

abstract class CartState {}

// Load Cart
class LoadingCartState extends CartState {}

class SuccessfulLoadedState extends CartState {
  final List<OrderItem> orderItems;

  SuccessfulLoadedState(this.orderItems);
}

class FailedLoadedState extends CartState {
  final String errorMessage;

  FailedLoadedState(this.errorMessage);
}

// Order
class OrderingCartState extends CartState {}

class SuccessfulOrderedState extends CartState {}

class FailedOrderedState extends CartState {
  final String errorMessage;

  FailedOrderedState(this.errorMessage);
}