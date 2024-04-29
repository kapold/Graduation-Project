import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_ap/blocs/menu/menu_event.dart';
import 'package:graduation_ap/blocs/menu/menu_state.dart';
import 'package:graduation_ap/models/product.dart';
import 'package:graduation_ap/repositories/product_repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(CommonState()) {
    on<GetAllMenuEvent>(_getAllMenu);
    on<DeleteMenuItemEvent>(_deleteMenuItem);
    on<AddMenuItemEvent>(_addMenuItem);
    on<ChangeMenuItemEvent>(_changeMenuItem);
  }

  Future<void> _getAllMenu(GetAllMenuEvent event, Emitter<MenuState> emit) async {
    try {
      emit(ProcessState());

      List<Product> products = await ProductRepository.getProducts();

      emit(SuccessfulLoadedMenu(products));
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> _addMenuItem(AddMenuItemEvent event, Emitter<MenuState> emit) async {
    try {
      emit(ProcessState());

      ProductRepository.addProduct(event.product);

      emit(SuccessfulAddedMenuItem());
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> _changeMenuItem(ChangeMenuItemEvent event, Emitter<MenuState> emit) async {
    try {
      emit(ProcessState());

      ProductRepository.changeProduct(event.product);

      emit(SuccessfulChangedMenuItem());
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }

  Future<void> _deleteMenuItem(DeleteMenuItemEvent event, Emitter<MenuState> emit) async {
    try {
      emit(ProcessState());

      ProductRepository.deleteProduct(event.productId);

      emit(SuccessfulDeletedMenuItem());
    }
    catch (error) {
      emit(FailedState(error.toString()));
    }
  }
}