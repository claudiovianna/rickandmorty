import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/domain/usecases/get_all_characters.dart';
import 'package:universo_rick_v2/features/characters/presentation/stores/character_store.dart';

import 'character_store_test.mocks.dart';

@GenerateMocks([GetAllCharacters])
void main() {
  late CharacterStore store;
  late MockGetAllCharacters mockGetAllCharacters;

  setUp(() {
    mockGetAllCharacters = MockGetAllCharacters();
    store = CharacterStore(mockGetAllCharacters);
  });

  group('CharacterStore', () {
    test('should have initial values', () {
      expect(store.characters, isEmpty);
      expect(store.isLoading, false);
      expect(store.errorMessage, isNull);
    });

    test('should set loading to true when getAllCharacters is called', () async {
      when(mockGetAllCharacters()).thenAnswer((_) async => []);

      final future = store.getAllCharacters();
      
      expect(store.isLoading, true);
      expect(store.errorMessage, isNull);
      
      await future;
    });

    test('should populate characters list on success', () async {
      final mockCharacters = [
        CharacterEntity(
          id: 1,
          name: 'Rick',
          image: 'image.jpg',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
        CharacterEntity(
          id: 2,
          name: 'Morty',
          image: 'image2.jpg',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
      ];

      when(mockGetAllCharacters()).thenAnswer((_) async => mockCharacters);

      await store.getAllCharacters();

      expect(store.characters.length, 2);
      expect(store.characters[0].name, 'Rick');
      expect(store.characters[1].name, 'Morty');
      expect(store.isLoading, false);
      expect(store.errorMessage, isNull);
    });

    test('should set error message on failure', () async {
      when(mockGetAllCharacters()).thenThrow(Exception('Network error'));

      await store.getAllCharacters();

      expect(store.characters, isEmpty);
      expect(store.isLoading, false);
      expect(store.errorMessage, 'Falha ao carregar personagens. Tente novamente');
    });

    test('should clear previous characters on new request', () async {
      final firstBatch = [
        CharacterEntity(
          id: 1,
          name: 'Rick',
          image: 'image.jpg',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
      ];

      final secondBatch = [
        CharacterEntity(
          id: 2,
          name: 'Morty',
          image: 'image2.jpg',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
      ];

      when(mockGetAllCharacters()).thenAnswer((_) async => firstBatch);
      await store.getAllCharacters();
      expect(store.characters.length, 1);

      when(mockGetAllCharacters()).thenAnswer((_) async => secondBatch);
      await store.getAllCharacters();
      
      expect(store.characters.length, 1);
      expect(store.characters[0].name, 'Morty');
    });

    test('should clear error message on new request', () async {
      when(mockGetAllCharacters()).thenThrow(Exception('Error'));
      await store.getAllCharacters();
      expect(store.errorMessage, isNotNull);

      when(mockGetAllCharacters()).thenAnswer((_) async => []);
      await store.getAllCharacters();
      
      expect(store.errorMessage, isNull);
    });

    test('should set loading to false even when exception occurs', () async {
      when(mockGetAllCharacters()).thenThrow(Exception('Error'));

      await store.getAllCharacters();

      expect(store.isLoading, false);
    });
  });
}