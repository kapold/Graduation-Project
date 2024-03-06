import '../../../models/product.dart';

abstract class MenuEvent {}

class GetMenuEvent extends MenuEvent {}

class SearchProductsEvent extends MenuEvent {
  final List<Product> products;
  final String searchRequest;

  SearchProductsEvent(this.products, this.searchRequest);
}
