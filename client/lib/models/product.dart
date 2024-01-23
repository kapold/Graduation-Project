import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int id;
  String name;
  String description;
  double price;
  String size;
  bool isVegetarian;
  List<String> toppings;
  String imageUrl;
  bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.size,
    required this.isVegetarian,
    required this.toppings,
    required this.imageUrl,
    required this.isAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      size: json['size'],
      isVegetarian: json['isVegetarian'],
      toppings: json['toppings'] != null ? List<String>.from(json['toppings']) : [],
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'size': size,
      'isVegetarian': isVegetarian,
      'toppings': toppings,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
    };
  }

  @override
  List<Object?> get props => [id];
}
