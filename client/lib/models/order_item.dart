import 'package:hive/hive.dart';

part 'order_item.g.dart';

@HiveType(typeId: 0)
class OrderItem {
  @HiveField(0)
  int? id;
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
  int quantity;
  @HiveField(7)
  double price;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.size,
    required this.dough,
    required this.toppings,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['orderId'],
      productId: json['productId'],
      size: json['size'],
      dough: json['dough'],
      toppings: List<String>.from(json['toppings']),
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'size': size,
      'dough': dough,
      'toppings': toppings.map((topping) => topping.toString()).toList(),
      'quantity': quantity,
      'price': price,
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
        'quantity: $quantity, '
        'price: $price'
    '}';
  }
}