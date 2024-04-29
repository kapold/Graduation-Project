import 'package:equatable/equatable.dart';

class Product extends Equatable {
  int id;
  String name;
  String description;
  double price;
  double calories;
  double protein;
  double fats;
  double carbohydrates;
  int weight;
  String imageUrl;
  bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbohydrates,
    required this.weight,
    required this.imageUrl,
    required this.isAvailable,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      carbohydrates: (json['carbohydrates'] as num).toDouble(),
      weight: json['weight'],
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
      'calories': calories,
      'protein': protein,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'weight': weight,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
    };
  }

  @override
  String toString() {
    return 'Product {price: $price, weight: $weight}';
  }

  @override
  List<Object?> get props => [id];
}
