import 'package:dio/dio.dart';
import 'package:universo_rick_v2/core/utils/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Dio get client => dio;
}
