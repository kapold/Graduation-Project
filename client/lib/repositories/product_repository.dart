import 'package:client/utils/logs.dart';
import 'package:dio/dio.dart';
import '../models/product.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class ProductRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<List<Product>> getProducts() async {
    final response = await dio.get('${Statics.baseUri}${Statics.productsUri}');

    Logs.infoLog('Products Data\n${response.data}');
    if (response.statusCode == 200) {
      List<Product> products = [];
      List<dynamic> productsJson = response.data;

      for (var productJson in productsJson) {
        products.add(Product.fromJson(productJson));
      }
      return products;
    }
    else {
      throw Exception('Products Get error');
    }
  }
}
