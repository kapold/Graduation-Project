import 'package:client/utils/logs.dart';
import 'package:dio/dio.dart';
import '../models/user.dart';
import '../utils/statics.dart';

class UserRepository {
  static final BaseOptions baseOptions = BaseOptions(
    followRedirects: false,
    validateStatus: (status) {
      return status! < 600;
    }
  );
  static final dio = Dio()..options=baseOptions;

  static Future<User> login(String phoneNumber, String password) async {
    final response = await dio.get(
        '${Statics.baseUri}${Statics.userUri}login',
        data: {
          'phoneNumber': phoneNumber,
          'password': password
        }
    );

    if (response.statusCode == 200) {
      Logs.infoLog('Login Data\n${response.data}');
      return User.fromJson(response.data);
    }
    else if (response.statusCode == 404) {
      throw Exception('User not found (404)');
    }
    else {
      Logs.infoLog('Login Failed (${response.statusCode})');
      Logs.infoLog('Login Data\n${response.data}');
      throw Exception('Error: Login');
    }
  }

  static Future<User> register(String phoneNumber, String password, String name) async {
    final response = await dio.post(
        '${Statics.baseUri}${Statics.userUri}register',
        data: {
          'phoneNumber': phoneNumber,
          'password': password,
          'name': name
        }
    );

    if (response.statusCode == 200) {
      Logs.infoLog('Register Data\n${response.data}');
      return User.fromJson(response.data);
    }
    else if (response.statusCode == 400) {
      throw Exception('Invalid data');
    }
    else {
      Logs.infoLog('Login Failed (${response.statusCode})');
      Logs.infoLog('Login Data\n${response.data}');
      throw Exception('Error: Login');
    }
  }

  static Future<Response<dynamic>> auth(String token) async {
    final response = await dio.get(
        '${Statics.baseUri}${Statics.userUri}auth',
        data: {
          'token': token
        }
    );

    if (response.statusCode == 200) {
      Logs.infoLog('Auth Data\n${response.data}');
      return response;
    }
    else if (response.statusCode == 500) {
      Logs.infoLog('Token is expired');
      return response;
    }
    else {
      Logs.infoLog('Auth Failed (${response.statusCode})');
      Logs.infoLog('Auth Data\n${response.data}');
      throw Exception('Error: Auth');
    }
  }

  static Future<User> getUserById(int id) async {
    final response = await dio.get(
        '${Statics.baseUri}${Statics.userUri}$id'
    );

    if (response.statusCode == 200) {
      Logs.infoLog('GetUserById Data\n${response.data}');
      return User.fromJson(response.data);
    }
    else if (response.statusCode == 404) {
      throw Exception('User not found (404)');
    }
    else {
      Logs.infoLog('Login Failed (${response.statusCode})');
      Logs.infoLog('Login Data\n${response.data}');
      throw Exception('Error: Login');
    }
  }
}