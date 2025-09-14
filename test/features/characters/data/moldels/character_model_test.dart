import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/features/characters/data/moldels/character_model.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';

void main() {
  // 1. ARRANGE (Organizar)
  // Criamos uma instância do modelo que será usada como referência nos testes.
  final tCharacterModel = CharacterModel(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    image: 'image_url',
    gender: 'Male',
    origin: 'Earth (C-137)',
  );

  // Criamos um Map (JSON) que representa os dados vindos da API.
  final tCharacterMap = {
    "id": 1,
    "name": "Rick Sanchez",
    "status": "Alive",
    "species": "Human",
    "image": "image_url",
    "gender": "Male",
    "origin": {"name": "Earth (C-137)"},
  };

  // Teste para garantir que o nosso Model é, de fato, uma extensão da Entity.
  // Isso é importante para a arquitetura, pois o repositório retornará a Entity.
  test('deve ser uma subclasse de CharacterEntity', () {
    // ASSERT (Verificar)
    expect(tCharacterModel, isA<CharacterEntity>());
  });

  // Agrupamos os testes relacionados à conversão de JSON para Model.
  group('fromJson', () {
    test(
      'deve retornar um CharacterModel válido a partir de um JSON completo',
      () {
        // 2. ACT (Agir)
        // Executamos o método que queremos testar.
        final result = CharacterModel.fromJson(tCharacterMap);

        // 3. ASSERT (Verificar)
        // Comparamos o objeto criado com a nossa instância de referência.
        // Usar `isA<CharacterModel>()` é uma boa prática para garantir o tipo.
        expect(result, isA<CharacterModel>());
        expect(result.id, tCharacterModel.id);
        expect(result.name, tCharacterModel.name);
        expect(result.origin, tCharacterModel.origin);
      },
    );

    test(
      'deve retornar um CharacterModel com valores padrão quando o JSON tiver dados nulos ou ausentes',
      () {
        // ARRANGE
        // Criamos um JSON vazio para forçar o uso dos valores padrão (??).
        final Map<String, dynamic> emptyJson = {
          "origin": {}, // Incluímos origin vazio para testar o 'name' aninhado
        };

        // ACT
        final result = CharacterModel.fromJson(emptyJson);

        // ASSERT
        // Verificamos se todos os campos receberam seus valores padrão.
        expect(result.id, 0);
        expect(result.name, '');
        expect(result.status, '');
        expect(result.species, '');
        expect(result.image, '');
        expect(result.gender, '');
        expect(result.origin, 'desconhecida');
      },
    );
  });

  // Agrupamos os testes relacionados à conversão de Model para Entity.
  group('toEntity', () {
    test('deve converter o Model para uma Entity corretamente', () {
      // ACT
      // Chamamos o método de conversão.
      final entity = tCharacterModel.toEntity();

      // ASSERT
      // Verificamos se o objeto retornado é do tipo correto e se os dados foram mantidos.
      expect(entity, isA<CharacterEntity>());
      expect(entity.id, tCharacterModel.id);
      expect(entity.name, tCharacterModel.name);
      expect(entity.origin, tCharacterModel.origin);
    });
  });
}
