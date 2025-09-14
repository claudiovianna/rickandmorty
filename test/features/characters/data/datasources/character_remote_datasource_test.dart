// Importações necessárias para o teste
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Importações do seu projeto
import 'package:universo_rick_v2/core/utils/api_constants.dart';
import 'package:universo_rick_v2/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:universo_rick_v2/features/characters/data/moldels/character_model.dart';

// Importa o arquivo que será gerado pelo Mockito
import 'character_remote_datasource_test.mocks.dart';

// Anotação para o build_runner saber qual classe mockar
@GenerateMocks([Dio])
void main() {
  // Declaração das variáveis que serão usadas nos testes
  late CharacterRemoteDatasourceImpl datasource;
  late MockDio mockDio; // MockDio é a classe que será gerada

  // O `setUp` é executado ANTES de cada teste, garantindo um ambiente limpo
  setUp(() {
    mockDio = MockDio();
    datasource = CharacterRemoteDatasourceImpl(mockDio);
  });

  // Um JSON de exemplo para simular a resposta da API
  final tCharacterListJson = {
    "results": [
      {
        "id": 1,
        "name": "Rick Sanchez",
        "status": "Alive",
        "species": "Human",
        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        "gender": "Male",
        "origin": {"name": "Earth"},
      },
      {
        "id": 2,
        "name": "Morty Smith",
        "status": "Alive",
        "species": "Human",
        "image": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        "gender": "Male",
        "origin": {"name": "Earth"},
      },
    ],
  };

  // Agrupa os testes relacionados ao método getAllCharacters
  group('getAllCharacters', () {
    test(
      'deve retornar uma lista de CharacterModel quando a chamada for bem-sucedida (status 200)',
      () async {
        // ARRANGE (Organizar)
        // Aqui, configuramos o comportamento do mock.
        // Quando o método `get` do mockDio for chamado com o endpoint correto...
        debugPrint('RESULT DIO 1: ${tCharacterListJson.toString()}');
        when(mockDio.get(ApiConstants.characterEndpoint))
        // ...ele deve responder (thenAnswer) com um objeto Response simulado.
        .thenAnswer(
          (_) async => Response(
            data: tCharacterListJson,
            statusCode: 200,
            requestOptions: RequestOptions(
              path: ApiConstants.characterEndpoint,
            ),
          ),
        );

        debugPrint('RESULT DIO 2: ${tCharacterListJson.toString()}');
        // ACT (Agir)
        // Executamos o método que queremos testar.
        final result = await datasource.getAllCharacters();
        debugPrint('result 1: $result');
        debugPrint(result.toString());

        // ASSERT (Verificar)
        // Verificamos se o resultado é o esperado.
        expect(result, isA<List<CharacterModel>>());
        expect(result.length, 2);
        expect(result.first.name, 'Rick Sanchez');
        // Verifica se o método `get` do mock foi chamado exatamente uma vez com o endpoint correto.
        verify(mockDio.get(ApiConstants.characterEndpoint));
        // Garante que nenhuma outra interação com o mock ocorreu.
        verifyNoMoreInteractions(mockDio);
      },
    );

    test('deve lançar uma Exception quando a resposta não for 200', () async {
      // ARRANGE
      // Simulamos uma resposta de erro do servidor (ex: 404 Not Found).
      when(mockDio.get(ApiConstants.characterEndpoint)).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 404,
          requestOptions: RequestOptions(path: ApiConstants.characterEndpoint),
        ),
      );

      // ACT
      // Pegamos a referência do método para testar se ele lança uma exceção.
      final call = datasource.getAllCharacters;

      // ASSERT
      // Verificamos se a chamada ao método `call()` realmente lança uma Exception.
      expect(() => call(), throwsA(isA<Exception>()));
    });

    test(
      'deve lançar uma Exception quando o Dio lançar um erro (ex: sem internet)',
      () async {
        // ARRANGE
        // Simulamos um erro na própria chamada do Dio.
        when(mockDio.get(ApiConstants.characterEndpoint)).thenThrow(
          DioException(
            requestOptions: RequestOptions(
              path: ApiConstants.characterEndpoint,
            ),
            error: 'Connection failed',
          ),
        );

        // ACT
        final call = datasource.getAllCharacters;

        // ASSERT
        expect(() => call(), throwsA(isA<Exception>()));
      },
    );
  });
}
