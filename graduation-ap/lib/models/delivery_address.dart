import 'package:equatable/equatable.dart';

class DeliveryAddress extends Equatable {
  int id;
  int userId;
  String city;
  String street;
  String homeNumber;
  String flatNumber;

  DeliveryAddress({
    required this.id,
    required this.userId,
    required this.city,
    required this.street,
    required this.homeNumber,
    required this.flatNumber,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['id'],
      userId: json['userId'],
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      homeNumber: json['homeNumber'] ?? '',
      flatNumber: json['flatNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'city': city,
      'street': street,
      'homeNumber': homeNumber,
      'flatNumber': flatNumber,
    };
  }

  @override
  String toString() {
    return '$city, $street, $homeNumber${flatNumber.isNotEmpty ? ', $flatNumber' : ''}';
  }

  @override
  List<Object?> get props => [id];
}
