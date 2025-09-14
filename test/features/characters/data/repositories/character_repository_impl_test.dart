import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Importações do seu projeto
import 'package:universo_rick_v2/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:universo_rick_v2/features/characters/data/moldels/character_model.dart';
import 'package:universo_rick_v2/features/characters/data/repositories/character_repository_impl.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';

// Importa o arquivo que será gerado pelo Mockito
import 'character_repository_impl_test.mocks.dart';

// Anotação para o build_runner saber qual classe/interface mockar.
// É uma boa prática mockar a abstração (interface) e não a implementação.
@GenerateMocks([ICharacterRemoteDatasource])
void main() {
  // Declaração das variáveis que serão usadas nos testes
  late CharacterRepositoryImpl repository;
  late MockICharacterRemoteDatasource mockRemoteDatasource;

  // O `setUp` é executado ANTES de cada teste, garantindo um ambiente limpo
  setUp(() {
    mockRemoteDatasource = MockICharacterRemoteDatasource();
    repository = CharacterRepositoryImpl(mockRemoteDatasource);
  });

  // Dados de teste: uma lista de CharacterModel que simularemos como retorno do datasource
  final tCharacterModelList = [
    CharacterModel(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      image: 'url1',
      gender: 'Male',
      origin: 'Earth',
    ),
    CharacterModel(
      id: 2,
      name: 'Morty Smith',
      status: 'Alive',
      species: 'Human',
      image: 'url2',
      gender: 'Male',
      origin: 'Earth',
    ),
  ];

  // Dados de teste: uma lista de CharacterEntity, que é o resultado esperado do repositório
  // final List<CharacterEntity> tCharacterEntityList = tCharacterModelList;

  // Agrupa os testes relacionados ao método getAllCharacters
  group('getAllCharacters', () {
    test(
      'deve retornar uma lista de CharacterEntity quando a chamada ao datasource for bem-sucedida',
      () async {
        // ARRANGE (Organizar)
        // Configuramos o mock: quando `getAllCharacters` for chamado no datasource,
        // ele deve retornar nossa lista de modelos de teste.
        when(
          mockRemoteDatasource.getAllCharacters(),
        ).thenAnswer((_) async => tCharacterModelList);

        // ACT (Agir)
        // Executamos o método do repositório que queremos testar.
        final result = await repository.getAllCharacters();

        // ASSERT (Verificar)
        // Verificamos se o resultado é igual à nossa lista de entidades esperada.
        // Como CharacterModel herda de CharacterEntity, a comparação direta funciona.
        // expect(result, equals(tCharacterEntityList));
        // expect(result, isA<List<CharacterEntity>>());
        // expect(result.first.name, 'Rick Sanchez');
        expect(result.first.name, tCharacterModelList.first.name);
        expect(result.length, tCharacterModelList.length);
        expect(result, isA<List<CharacterEntity>>());
        // Verificamos se o método do datasource foi chamado exatamente uma vez.
        verify(mockRemoteDatasource.getAllCharacters());
        // Garantimos que nenhuma outra interação com o mock ocorreu.
        verifyNoMoreInteractions(mockRemoteDatasource);
      },
    );

    test('deve propagar a exceção quando a chamada ao datasource falhar', () async {
      // ARRANGE
      // Configuramos o mock para lançar uma exceção quando seu método for chamado.
      when(
        mockRemoteDatasource.getAllCharacters(),
      ).thenThrow(Exception('Falha na API'));

      // ACT
      // Pegamos a referência do método para testar se ele lança uma exceção.
      final call = repository.getAllCharacters;

      // ASSERT
      // Verificamos se a chamada ao método `call()` realmente lança uma Exception.
      // O repositório não deve tratar o erro, apenas repassá-lo para a camada superior (UseCase).
      expect(() => call(), throwsA(isA<Exception>()));
      // Verificamos que a tentativa de chamar o datasource foi feita.
      verify(mockRemoteDatasource.getAllCharacters());
      verifyNoMoreInteractions(mockRemoteDatasource);
    });
  });
}
