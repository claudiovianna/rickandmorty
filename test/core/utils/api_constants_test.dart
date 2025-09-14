import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/core/utils/api_constants.dart';

void main() {
  test('ApiConstants possui os valores esperados', () {
    expect(ApiConstants.baseUrl, 'https://rickandmortyapi.com/api');
    expect(ApiConstants.characterEndpoint, '/character');
  });
}
