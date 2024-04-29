import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/orders/orders_event.dart';
import 'package:graduation_ap/blocs/orders/orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(CommonState()) {
    on<GetOrdersEvent>(_getAllOrders);
  }

  Future<void> _getAllOrders(GetOrdersEvent event, Emitter<OrdersState> emit) async {
    try {

    }
    catch (error) {

    }
  }
}