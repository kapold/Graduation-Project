class Order {
  int id;
  int userId;
  String status;
  double totalPrice;

  Order({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        userId: json['userId'],
        status: json['status'],
        totalPrice: json['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'totalPrice': totalPrice,
    };
  }
}