import '../../models/delivery_address.dart';
import '../../models/order.dart';
import '../../models/order_item.dart';
import '../../models/product.dart';
import '../../models/user.dart';

abstract class OrdersEvent {}

class GetAllOrdersEvent extends OrdersEvent {}

class GetOrderInfoEvent extends OrdersEvent {
  final Order order;

  GetOrderInfoEvent(this.order);
}

class UpdateOrderStatusEvent extends OrdersEvent {
  final int orderId;
  final String newStatus;
  final List<OrderItem> orderItems;
  final List<Product> products;
  final User customer;
  final User? deliveryman;
  final DeliveryAddress deliveryAddress;

  UpdateOrderStatusEvent(this.orderId, this.newStatus, this.orderItems, this.products, this.customer, this.deliveryman, this.deliveryAddress);
}
