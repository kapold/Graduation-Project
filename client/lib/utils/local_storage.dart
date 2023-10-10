import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

class LocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true)
  );

  // static Future<void> saveUser(User user) async {
  //   await _storage.write(key: 'id', value: user.id);
  //   await _storage.write(key: 'username', value: user.phoneNumber);
  //   await _storage.write(key: 'password', value: user.password);
  //   await _storage.write(key: 'name', value: user.name);
  //   await _storage.write(key: 'token', value: user.token);
  // }
  //
  // static Future<User> getUser() async {
  //   User user = User(id: '', phoneNumber: '', password: '', name: '', token: '');
  //   user.id = await _storage.read(key: 'id') ?? '';
  //   user.phoneNumber = await _storage.read(key: 'phoneNumber') ?? '';
  //   user.password = await _storage.read(key: 'password') ?? '';
  //   user.name = await _storage.read(key: 'name') ?? '';
  //   user.token = await _storage.read(key: 'token') ?? '';
  //   return user;
  // }

  static Future<void> clearUserInfo() async {
    await _storage.delete(key: 'uid');
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
    await _storage.delete(key: 'name');
    await _storage.delete(key: 'token');
  }

  static Future<void> clearAllInfo() async {
    await _storage.deleteAll();
  }

  static Future<void> saveTheme(String theme) async {
    await _storage.write(key: 'theme', value: theme);
  }

  static Future<String> getTheme() async {
    return await _storage.read(key: 'theme') ?? 'light';
  }

  static Future<String> getToken() async {
    return await _storage.read(key: 'token') ?? '';
  }

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: 'token');
  }
}
