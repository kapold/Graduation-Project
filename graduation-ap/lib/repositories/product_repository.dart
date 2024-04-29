import 'package:dio/dio.dart';
import '../models/product.dart';
import '../utils/logs.dart';
import '../utils/statics.dart';
import 'dio_options.dart';

class ProductRepository {
  static final dio = Dio()..options = DioOptions.baseOptions;

  static Future<List<Product>> getProducts() async {
    final response = await dio.get('${Statics.baseUri}${Statics.productsUri}');

    Logs.infoLog('Products Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode == 200) {
      List<Product> products = [];
      List<dynamic> productsJson = response.data;

      for (var productJson in productsJson) {
        products.add(Product.fromJson(productJson));
      }
      return products;
    } else {
      throw Exception('Products Get error');
    }
  }

  static Future<Product> getProductById(int id) async {
    final response =
        await dio.get('${Statics.baseUri}${Statics.productsUri}/$id');

    Logs.infoLog('Product Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode == 200) {
      return Product.fromJson(response.data);
    } else {
      throw Exception('Product Get error');
    }
  }

  static void deleteProduct(int productId) async {
    final response = await dio.delete(
      '${Statics.baseUri}${Statics.productsUri}',
      data: {
        'productId': productId,
      },
    );

    Logs.infoLog('DeleteProduct Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Delete product error');
    }
  }

  static void addProduct(Product product) async {
    Logs.infoLog('SENT: ${product.toJson()}');
    final response = await dio.post(
      '${Statics.baseUri}${Statics.productsUri}',
      data: product.toJson(),
    );

    Logs.infoLog('AddProduct Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Add product error');
    }
  }

  static void changeProduct(Product product) async {
    Logs.infoLog('SENT: ${product.toJson()}');
    final response = await dio.put(
      '${Statics.baseUri}${Statics.productsUri}',
      data: product.toJson(),
    );

    Logs.infoLog('ChangeProduct Data\n${response.statusCode}\n${response.data}');
    if (response.statusCode != 200) {
      throw Exception('Change product error');
    }
  }
}
