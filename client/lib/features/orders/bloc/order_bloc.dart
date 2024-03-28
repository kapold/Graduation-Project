import 'package:client/features/orders/bloc/order_event.dart';
import 'package:client/features/orders/bloc/order_state.dart';
import 'package:client/models/order.dart';
import 'package:client/repositories/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(LoadingOrdersState()) {
    on<GetOrdersEvent>(_getOrdersHandler);
  }

  Future<void> _getOrdersHandler(GetOrdersEvent event, Emitter<OrderState> emit) async {
    try {
      List<Order> orders = await OrderRepository.getOrdersByUserId(event.userId);

      emit(SuccessfulLoadedState(orders));
    } catch (error) {
      emit(FailedLoadedState(error.toString()));
    }
  }
}
