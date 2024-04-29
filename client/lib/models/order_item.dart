import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'order_item.g.dart';

@HiveType(typeId: 0)
class OrderItem extends Equatable {
  @HiveField(0)
  String id;
  @HiveField(1)
  int? orderId;
  @HiveField(2)
  int productId;
  @HiveField(3)
  String size;
  @HiveField(4)
  String dough;
  @HiveField(5)
  List<String> toppings;
  @HiveField(6)
  List<String> removedCompositions;
  @HiveField(7)
  int quantity;
  @HiveField(8)
  double price;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.size,
    required this.dough,
    required this.toppings,
    required this.removedCompositions,
    required this.quantity,
    required this.price,
  });

  String get doughFormatted {
    switch (dough) {
      case 'thin':
        return 'Тонкое';
      case 'traditional':
        return 'Традиционное';
      default:
        return 'Неизвестное тесто';
    }
  }

  String get sizeFormatted {
    switch (size) {
      case 'small':
        return 'Маленькая 25 см';
      case 'medium':
        return 'Средняя 30 см';
      case 'large':
        return 'Большая 35 см';
      default:
        return 'Неизвестный размер';
    }
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'].toString(),
      orderId: json['orderId'],
      productId: json['productId'],
      size: json['size'],
      dough: json['dough'],
      toppings: List<String>.from(json['toppings'] ?? ''),
      removedCompositions: List<String>.from(json['removedCompositions'] ?? ''),
      quantity: json['quantity'],
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'size': size,
      'dough': dough,
      'toppings': toppings,
      'removedCompositions': removedCompositions,
      'quantity': quantity,
      'price': price.toStringAsFixed(2),
    };
  }

  @override
  String toString() {
    return 'OrderItem {'
        'id: $id, '
        'orderId: $orderId, '
        'productId: $productId, '
        'size: $size, '
        'dough: $dough, '
        'toppings: $toppings, '
        'removedCompositions: $removedCompositions, '
        'quantity: $quantity, '
        'price: $price'
    '}';
  }

  @override
  List<Object?> get props => [orderId, productId, size, dough, toppings, price];
}