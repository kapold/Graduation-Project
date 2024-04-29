import 'package:dio/dio.dart';

class DioOptions {
  static final BaseOptions baseOptions = BaseOptions(
    contentType: 'application/json',
    followRedirects: false,
    validateStatus: (status) {
      return status! < 600;
    },
  );
}
