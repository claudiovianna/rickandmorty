import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/core/services/dio_client.dart';
import 'package:universo_rick_v2/core/utils/api_constants.dart';

void main() {
  test('DioClient configura Dio corretamente', () {
    final dio = Dio();
    final dioClient = DioClient(dio);

    expect(dioClient.client.options.baseUrl, ApiConstants.baseUrl);
    expect(
      dioClient.client.options.connectTimeout,
      const Duration(milliseconds: 5000),
    );
    expect(
      dioClient.client.options.receiveTimeout,
      const Duration(milliseconds: 3000),
    );
    expect(
      dioClient.client.options.headers['Content-Type'],
      'application/json',
    );
    expect(dioClient.client.options.headers['Accept'], 'application/json');
  });
}
