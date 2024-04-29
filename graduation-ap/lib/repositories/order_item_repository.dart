import 'package:dio/dio.dart';
import '../models/order_item.dart';
import '../utils/logs.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class OrderItemRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<List<OrderItem>> getOrderItemsByOrderId(int orderId) async {
    final response = await dio.get(
      '${Statics.baseUri}${Statics.orderItemsUri}/$orderId',
    );

    Logs.infoLog('GetOrderItemsByOrderId Data\n${response.data}');
    if (response.statusCode == 200) {
      List<OrderItem> orderItems = [];
      List<dynamic> ordersItemsJson = response.data;

      for (var ordersItemJson in ordersItemsJson) {
        orderItems.add(OrderItem.fromJson(ordersItemJson));
      }
      return orderItems;
    } else if (response.statusCode == 404) {
      Logs.infoLog('Order items not found');
    } else {
      Logs.infoLog('GetOrderItemsByOrderId error');
    }
    return [];
  }
}
