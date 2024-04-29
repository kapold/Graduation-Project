import '../../models/product.dart';

abstract class MenuState {}

class CommonState extends MenuState {}

class FailedState extends MenuState {
  final String errorMessage;

  FailedState(this.errorMessage);
}

class ProcessState extends MenuState {}

class SuccessfulLoadedMenu extends MenuState {
  final List<Product> products;

  SuccessfulLoadedMenu(this.products);
}

class SuccessfulDeletedMenuItem extends MenuState {}

class SuccessfulAddedMenuItem extends MenuState {}

class SuccessfulChangedMenuItem extends MenuState {}
