import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';

abstract class ICharacterRepository {
  Future<List<CharacterEntity>> getAllCharacters();
}
