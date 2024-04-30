import 'package:dio/dio.dart';
import '../models/order.dart';
import '../models/order_item.dart';
import '../utils/logs.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class OrderRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<void> addOrder(int userId, int deliveryAddressId, String paymentType, double totalPrice, List<OrderItem> orderItems) async {
    final response = await dio.post(
      '${Statics.baseUri}${Statics.ordersUri}',
      data: {
        'userId': userId,
        'deliveryAddressId': deliveryAddressId,
        'paymentType': paymentType,
        'totalPrice': totalPrice.toStringAsFixed(2),
        'orderItems': orderItems.map((item) => item.toJson()).toList(),
      },
    );

    Logs.infoLog('AddOrder Data\n${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Ошибка заказа');
    }
  }

  static Future<List<Order>> getOrdersByUserId(int userId) async {
    final response = await dio.get(
      '${Statics.baseUri}${Statics.ordersUri}/$userId',
    );

    Logs.infoLog('GetOrdersByUserId Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode == 200) {
      List<Order> orders = [];
      List<dynamic> ordersJson = response.data;

      for (var orderJson in ordersJson) {
        orders.add(Order.fromJson(orderJson));
      }
      return orders;
    } else if (response.statusCode == 404) {
      Logs.infoLog('Orders not found');
    } else {
      Logs.infoLog('GetOrdersByUserId error');
    }
    return [];
  }

  static Future<List<OrderItem>> getOrderItems(int orderId) async {
    final response = await dio.get(
      '${Statics.baseUri}${Statics.ordersUri}',
      data: {
        'orderId': orderId,
      },
    );

    Logs.infoLog('GetOrderItems Data\n${response.data}');
    if (response.statusCode == 200) {

    } else if (response.statusCode == 404) {
      Logs.infoLog('Order items not found');
    } else {
      Logs.infoLog('GetOrderItems error');
    }
    return [];
  }
}
