import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
// Importações do seu projeto
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/domain/repositories/character_repository.dart';
import 'package:universo_rick_v2/features/characters/domain/usecases/get_all_characters.dart';

// Importa o arquivo que será gerado pelo Mockito
import 'get_all_characters_test.mocks.dart';

// Anotação para o build_runner saber qual interface mockar
@GenerateMocks([ICharacterRepository])
void main() {
  // Declaração das variáveis que serão usadas nos testes
  late GetAllCharacters usecase;
  late MockICharacterRepository mockCharacterRepository;

  // O `setUp` é executado ANTES de cada teste
  setUp(() {
    mockCharacterRepository = MockICharacterRepository();
    usecase = GetAllCharacters(mockCharacterRepository);
  });

  // Dados de teste: uma lista de CharacterEntity que simularemos como retorno do repositório
  final tCharacterEntityList = [
    CharacterEntity(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      image: 'url1',
      gender: 'Male',
      origin: 'Earth',
    ),
  ];

  test('deve obter a lista de personagens do repositório', () async {
    // ARRANGE (Organizar)
    // Configuramos o mock: quando o método `getAllCharacters` do repositório for chamado...
    when(mockCharacterRepository.getAllCharacters())
    // ...ele deve responder (thenAnswer) com a nossa lista de entidades de teste.
    .thenAnswer((_) async => tCharacterEntityList);

    // ACT (Agir)
    // Executamos o UseCase. Como ele tem um método `call`, podemos invocá-lo como se fosse uma função.
    final result = await usecase(); // ou usecase.call()

    // ASSERT (Verificar)
    // Verificamos se o resultado do UseCase é exatamente o que o mock do repositório retornou.
    expect(result, tCharacterEntityList);
    // Verificamos se o método `getAllCharacters` do repositório foi chamado exatamente uma vez.
    // Isso confirma que o UseCase está se comunicando corretamente com sua dependência.
    verify(mockCharacterRepository.getAllCharacters());
    // Garantimos que nenhuma outra interação com o mock ocorreu.
    verifyNoMoreInteractions(mockCharacterRepository);
  });

  test('deve propagar a exceção vinda do repositório', () async {
    // ARRANGE
    // Configuramos o mock para lançar uma exceção
    when(
      mockCharacterRepository.getAllCharacters(),
    ).thenThrow(Exception('Erro no repositório'));

    // ACT
    final call = usecase;

    // ASSERT
    // Verificamos se a chamada ao usecase repassa a exceção
    expect(() => call(), throwsA(isA<Exception>()));
    verify(mockCharacterRepository.getAllCharacters());
    verifyNoMoreInteractions(mockCharacterRepository);
  });
}
