import 'package:client/features/cart/bloc/cart_event.dart';
import 'package:client/features/cart/bloc/cart_state.dart';
import 'package:client/models/order_item.dart';
import 'package:client/repositories/order_repository.dart';
import 'package:client/utils/local_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(LoadingCartState()) {
    on<GetCartEvent>(_getCartHandler);
    on<OrderCartEvent>(_orderCart);
  }

  Future<void> _getCartHandler(GetCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingCartState());

      List<OrderItem> orderItems = await LocalDb().getAllOrderItems();

      emit(SuccessfulLoadedState(orderItems));
    } catch (error) {
      emit(FailedLoadedState(error.toString()));
    }
  }

  Future<void> _orderCart(OrderCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(OrderingCartState());
      
      OrderRepository.addOrder(
        event.userId,
        event.deliveryAddressId,
        event.paymentType,
        event.totalPrice,
        event.orderItems,
      );

      emit(SuccessfulOrderedState());
    } catch (error) {
      emit(FailedOrderedState(error.toString()));
    }
  }
}
