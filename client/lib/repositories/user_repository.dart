import 'package:client/utils/logs.dart';
import 'package:dio/dio.dart';
import '../models/user.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class UserRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<User> login(String phoneNumber, String password) async {
    final response = await dio.get('${Statics.baseUri}${Statics.userUri}login',
        data: {'phoneNumber': phoneNumber, 'password': password});

    Logs.infoLog('Login Data\n${response.data}');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Error: Login');
    }
  }

  static Future<Map<String, dynamic>> getUserGeoById(int userId) async {
    final response = await dio.get(
      '${Statics.baseUri}${Statics.userUri}geo',
      data: {
        'id': userId,
      },
    );

    Logs.infoLog('GetUserGeoById Data\n${response.data}');
    if (response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Error: Login');
    }
  }

  static Future<User> register(
      String phoneNumber, String password, String name, String role) async {
    final response =
        await dio.post('${Statics.baseUri}${Statics.userUri}register', data: {
      'phoneNumber': phoneNumber,
      'password': password,
      'name': name,
      'role': role,
    });

    Logs.infoLog('Register Data\n${response.data}');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else if (response.statusCode == 400) {
      throw Exception('Invalid data');
    } else if (response.statusCode == 409) {
      throw Exception('User already exists');
    } else {
      throw Exception('Register error');
    }
  }

  static Future<Response<dynamic>> auth(String token) async {
    final response = await dio.get('${Statics.baseUri}${Statics.userUri}auth',
        data: {'token': token});

    // Logs.infoLog('Auth Data\n${response.data}');
    if (response.statusCode == 200) {
      return response;
    } else if (response.statusCode == 500) {
      return response;
    } else {
      throw Exception('Auth error');
    }
  }

  static Future<User> getUserById(int id) async {
    final response = await dio.get('${Statics.baseUri}${Statics.userUri}$id');

    // Logs.infoLog('GetUserById Data\n${response.data}');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('GetUserById error');
    }
  }

  static Future<void> deleteUserById(int id) async {
    final response = await dio
        .delete('${Statics.baseUri}${Statics.userUri}', data: {'id': id});

    Logs.infoLog('Delete User Data\n${response.data}');
    if (response.statusCode == 400) {
      throw Exception('Invalid Id');
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('User delete error');
    }
  }

  static Future<void> updateUserById(int id, String name) async {
    final response = await dio.put('${Statics.baseUri}${Statics.userUri}',
        data: {'id': id, 'name': name});

    Logs.infoLog('Update User Data\n${response.data}');
    if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Update user error');
    }
  }
}
