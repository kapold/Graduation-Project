import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';

class LocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true)
  );

  static Future<void> saveUser(User user) async {
    await _storage.write(key: 'uid', value: user.uid);
    await _storage.write(key: 'username', value: user.username);
    await _storage.write(key: 'password', value: user.password);
    // other user fields...
  }

  static Future<User> getUser() async {
    User user = User(uid: '', username: '', password: '');
    user.uid = await _storage.read(key: 'uid') ?? '';
    user.username = await _storage.read(key: 'username') ?? '';
    user.password = await _storage.read(key: 'password') ?? '';
    // other user fields...
    return user;
  }

  static Future<void> clearUserInfo() async {
    await _storage.delete(key: 'uid');
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
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
}
