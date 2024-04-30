import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/orders/orders_event.dart';
import 'package:graduation_ap/blocs/orders/orders_state.dart';
import 'package:graduation_ap/models/delivery_address.dart';
import 'package:graduation_ap/models/order_item.dart';
import 'package:graduation_ap/models/product.dart';
import 'package:graduation_ap/repositories/address_repository.dart';
import 'package:graduation_ap/repositories/order_item_repository.dart';
import 'package:graduation_ap/repositories/order_repository.dart';
import 'package:graduation_ap/repositories/product_repository.dart';
import 'package:graduation_ap/repositories/user_repository.dart';
import 'package:graduation_ap/utils/logs.dart';

import '../../models/order.dart';
import '../../models/user.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(CommonState()) {
    on<GetAllOrdersEvent>(_getAllOrders);
    on<GetOrderInfoEvent>(_getOrderInfo);
    on<UpdateOrderStatusEvent>(_updateOrderStatus);
  }

  Future<void> _getAllOrders(GetAllOrdersEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(ProcessState());

      List<Order> orders = await OrderRepository.getAllOrders();

      emit(SuccessfulLoadedOrdersState(orders));
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> _getOrderInfo(GetOrderInfoEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(ProcessState());

      List<OrderItem> orderItems = await OrderItemRepository.getOrderItemsByOrderId(event.order.id);
      List<Product> products = await ProductRepository.getProducts();
      User customer = await UserRepository.getUserById(event.order.userId);
      User? deliveryman;
      if (event.order.deliverymanId != null) {
        deliveryman = await UserRepository.getUserById(event.order.deliverymanId ?? 0);
      }
      DeliveryAddress deliveryAddress = await AddressRepository.getDeliveryAddress(event.order.deliveryAddressId);

      emit(SuccessfulLoadedOrderInfoState(orderItems, products, customer, deliveryman, deliveryAddress));
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> _updateOrderStatus(UpdateOrderStatusEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(ProcessState());

      OrderRepository.updateOrderStatus(event.orderId, event.newStatus);

      emit(SuccessfulUpdatedOrderStatusState(event.orderItems, event.products, event.customer, event.deliveryman, event.deliveryAddress));
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }
}