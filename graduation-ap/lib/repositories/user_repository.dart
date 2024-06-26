import 'package:dio/dio.dart';
import 'package:graduation_ap/utils/app_data.dart';

import '../models/user.dart';
import '../utils/logs.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class UserRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<User> auth(String accessKey) async {
    final response = await dio.post(
      '${Statics.baseUri}${Statics.userUri}panel/auth',
      data: {
        'accessKey': accessKey,
      },
    );

    Logs.infoLog('Auth Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Auth error');
    }
  }

  static Future<User> getUserById(int userId) async {
    final response = await dio.get(
      '${Statics.baseUri}${Statics.userUri}$userId',
    );

    Logs.infoLog('GetUserById Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode == 200) {
      return User.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('User get error');
    }
  }

  static Future<void> updateUserGeo(double latitude, double longitude) async {
    final response = await dio.put(
      '${Statics.baseUri}${Statics.userUri}/geo',
      data: {
        'id': AppData.currentUser.id,
        'latitude': latitude,
        'longitude': longitude,
      },
    );

    Logs.infoLog('UpdateUserGeo Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Update geo error');
    }
  }
}
