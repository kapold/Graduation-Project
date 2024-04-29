import 'package:equatable/equatable.dart';

class Topping extends Equatable {
  int id;
  String name;
  double price;
  bool isSelected = false;

  Topping({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  @override
  String toString() {
    return 'isSelected: $isSelected}';
  }

  @override
  List<Object?> get props => [id];
}
