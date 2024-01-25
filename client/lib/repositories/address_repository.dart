import 'package:client/models/delivery_address.dart';
import 'package:client/utils/logs.dart';
import 'package:dio/dio.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class AddresseRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<List<DeliveryAddress>> getUserAddresses(int userId) async {
    final response = await dio.get('${Statics.baseUri}${Statics.addressesUri}',
      data: { 'userId': userId });

    Logs.infoLog('GetUserAddresses Data\n${response.data}');
    if (response.statusCode == 200) {
      List<DeliveryAddress> addresses = [];
      List<dynamic> addressesJson = response.data;

      for (var addressJson in addressesJson) {
        addresses.add(DeliveryAddress.fromJson(addressJson));
      }
      return addresses;
    }
    else if (response.statusCode == 404) {
      Logs.infoLog('Addresses not found');
    }
    else {
      Logs.infoLog('GetUserAddresses error');
    }
    return [];
  }
}
