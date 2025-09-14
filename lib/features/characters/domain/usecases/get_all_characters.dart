import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/domain/repositories/character_repository.dart';

class GetAllCharacters {
  final ICharacterRepository repository;

  GetAllCharacters(this.repository);

  Future<List<CharacterEntity>> call() async {
    return await repository.getAllCharacters();
  }
}
