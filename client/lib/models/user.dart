import 'package:equatable/equatable.dart';

class User extends Equatable {
  String uid;
  String username;
  String password;

  User({
    required this.uid,
    required this.username,
    required this.password
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'password': password,
    };
  }

  @override
  List<Object?> get props => [uid];
}
