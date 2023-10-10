import 'package:equatable/equatable.dart';

class User extends Equatable {
  int id;
  String phoneNumber;
  String password;
  String name;
  String token;

  User({
    required this.id,
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      name: json['name'],
      token: json['token']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'token': token
    };
  }

  @override
  List<Object?> get props => [id];
}
