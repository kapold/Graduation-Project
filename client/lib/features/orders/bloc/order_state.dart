import '../../../models/order.dart';

abstract class OrderState {}

class LoadingOrdersState extends OrderState {}

class SuccessfulLoadedState extends OrderState {
  final List<Order> orders;

  SuccessfulLoadedState(this.orders);
}

class FailedLoadedState extends OrderState {
  final String errorMessage;

  FailedLoadedState(this.errorMessage);
}