class OrderItem {
  int id;
  int orderId;
  int productId;
  String size;
  bool isVegetarian;
  List<String> toppings;
  int quantity;
  double price;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.size,
    required this.isVegetarian,
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
      isVegetarian: json['isVegetarian'],
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
      'isVegetarian': isVegetarian,
      'toppings': toppings.map((topping) => topping.toString()).toList(),
      'quantity': quantity,
      'price': price,
    };
  }
}