import 'package:graduation_ap/models/product.dart';

abstract class MenuEvent {}

class GetAllMenuEvent extends MenuEvent {}

class DeleteMenuItemEvent extends MenuEvent {
  final int productId;

  DeleteMenuItemEvent(this.productId);
}

class UpdateMenuItemEvent extends MenuEvent {
  final Product product;

  UpdateMenuItemEvent(this.product);
}

class AddMenuItemEvent extends MenuEvent {
  final Product product;

  AddMenuItemEvent(this.product);
}

class ChangeMenuItemEvent extends MenuEvent {
  final Product product;

  ChangeMenuItemEvent(this.product);
}
