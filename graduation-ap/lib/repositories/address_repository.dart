import 'package:dio/dio.dart';
import '../models/delivery_address.dart';
import '../utils/logs.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class AddressRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<DeliveryAddress> getDeliveryAddress(int addressId) async {
    final response = await dio.get(
      '${Statics.baseUri}${Statics.addressesUri}$addressId',
    );

    Logs.infoLog('GetDeliveryAddress Data\n${response.data}');
    if (response.statusCode == 200) {
      return DeliveryAddress.fromJson(response.data);
    } else if (response.statusCode == 404) {
      throw Exception('Address not found');
    } else {
      throw Exception('GetUserAddresses error');
    }
  }

  static Future<List<DeliveryAddress>> getUserAddresses(int userId) async {
    final response = await dio.get('${Statics.baseUri}${Statics.addressesUri}',
        data: {'userId': userId});

    Logs.infoLog('GetUserAddresses Data\n${response.data}');
    if (response.statusCode == 200) {
      List<DeliveryAddress> addresses = [];
      List<dynamic> addressesJson = response.data;

      for (var addressJson in addressesJson) {
        addresses.add(DeliveryAddress.fromJson(addressJson));
      }
      return addresses;
    } else if (response.statusCode == 404) {
      Logs.infoLog('Addresses not found');
    } else {
      Logs.infoLog('GetUserAddresses error');
    }
    return [];
  }

  static void addUserAddress(int userId, DeliveryAddress address) async {
    final response = await dio.post(
      '${Statics.baseUri}${Statics.addressesUri}',
      data: {
        'userId': userId,
        'address': address,
      },
    );

    Logs.infoLog('AddUserAddress Data\n${response.data}');
    if (response.statusCode == 404) {
      Logs.infoLog('Addresses not found');
    }
  }

  static void deleteUserAddress(int addressId) async {
    final response = await dio.delete(
        '${Statics.baseUri}${Statics.addressesUri}',
        data: {'addressId': addressId});

    Logs.infoLog('DeleteUserAddress Data\n${response.data}');
  }
}
