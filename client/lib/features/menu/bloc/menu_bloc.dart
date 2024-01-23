import 'package:client/features/menu/bloc/menu_event.dart';
import 'package:client/features/menu/bloc/menu_state.dart';
import 'package:client/models/product.dart';
import 'package:client/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(LoadingMenuState()) {
    on<GetMenuEvent>(_getMenuHandler);
  }

  Future<void> _getMenuHandler(GetMenuEvent event, Emitter<MenuState> emit) async {
    try {
      List<Product> products = await ProductRepository.getProducts();

      emit(SuccessfulLoadedState(products));
    }
    catch (error) {
      emit(FailedLoadedState(error.toString()));
    }
  }
}