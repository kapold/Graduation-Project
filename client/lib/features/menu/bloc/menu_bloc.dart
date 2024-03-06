import 'package:client/features/menu/bloc/menu_event.dart';
import 'package:client/features/menu/bloc/menu_state.dart';
import 'package:client/models/product.dart';
import 'package:client/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(LoadingMenuState()) {
    on<GetMenuEvent>(_getMenuHandler);
    on<SearchProductsEvent>(_searchHandler);
  }

  Future<void> _getMenuHandler(
      GetMenuEvent event, Emitter<MenuState> emit) async {
    try {
      List<Product> products = await ProductRepository.getProducts();

      emit(SuccessfulLoadedState(products));
    } catch (error) {
      emit(FailedLoadedState(error.toString()));
    }
  }

  Future<void> _searchHandler(
      SearchProductsEvent event, Emitter<MenuState> emit) async {
    try {
      emit(LoadingMenuState());

      List<Product> searchResult = event.products
          .where((product) =>
              '${product.name}${product.description}${product.price}'
                  .toLowerCase()
                  .contains(event.searchRequest.toLowerCase()))
          .toList();

      emit(SearchResultState(searchResult));
    } catch (error) {
      emit(FailedLoadedState(error.toString()));
    }
  }
}
