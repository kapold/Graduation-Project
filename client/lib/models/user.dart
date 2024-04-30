import 'package:equatable/equatable.dart';

class User extends Equatable {
  int id;
  String phoneNumber;
  String password;
  String name;
  String accessKey;
  String token;
  String role;
  double latitude;
  double longitude;

  User({
    required this.id,
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.accessKey,
    required this.token,
    required this.role,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      name: json['name'],
      accessKey: json['accessKey'].toString(),
      token: json['token'],
      role: json['role'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'accessKey': accessKey,
      'token': token,
      'role': role,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  List<Object?> get props => [id];
}
