import 'package:client/models/product.dart';

abstract class MenuState {}

class LoadingMenuState extends MenuState {}

class SuccessfulLoadedState extends MenuState {
  final List<Product> products;

  SuccessfulLoadedState(this.products);
}

class FailedLoadedState extends MenuState {
  final String errorMessage;

  FailedLoadedState(this.errorMessage);
}

class SearchResultState extends MenuState {
  final List<Product> products;

  SearchResultState(this.products);
}
