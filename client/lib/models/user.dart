import 'package:equatable/equatable.dart';

class User extends Equatable {
  int id;
  String phoneNumber;
  String password;
  String name;
  String token;
  bool isAdmin;
  bool isStaff;

  User({
    required this.id,
    required this.phoneNumber,
    required this.password,
    required this.name,
    required this.token,
    required this.isAdmin,
    required this.isStaff
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      name: json['name'],
      token: json['token'],
      isAdmin: json['isAdmin'],
      isStaff: json['isStaff']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'token': token,
      'isAdmin': isAdmin,
      'isStaff': isStaff
    };
  }

  @override
  List<Object?> get props => [id];
}
