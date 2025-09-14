import 'package:universo_rick_v2/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements ICharacterRepository {
  final ICharacterRemoteDatasource remoteDatasource;

  CharacterRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<CharacterEntity>> getAllCharacters() async {
    final characterModels = await remoteDatasource.getAllCharacters();
    return characterModels.map((model) => model.toEntity()).toList();
  }
}
