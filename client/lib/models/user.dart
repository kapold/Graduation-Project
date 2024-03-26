import 'package:equatable/equatable.dart';

class User extends Equatable {
  int id;
  String phoneNumber;
  String password;
  String name;
  String token;
  String role;

  User({
    required this.id,
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.token,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      name: json['name'],
      token: json['token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'token': token,
      'role': role,
    };
  }

  @override
  List<Object?> get props => [id];
}
