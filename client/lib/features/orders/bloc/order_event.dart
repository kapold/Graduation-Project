abstract class OrderEvent {}

class GetOrdersEvent extends OrderEvent {
  final int userId;

  GetOrdersEvent(this.userId);
}
