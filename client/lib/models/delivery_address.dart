import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  int id;
  int userId;
  String address;

  DeliveryAddress({
    required this.id,
    required this.userId,
    required this.address,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
        id: json['id'],
        userId: json['userId'],
        address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'address': address,
    };
  }

  @override
  List<Object?> get props => [id];
}
