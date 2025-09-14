import 'package:dio/dio.dart';
import 'package:universo_rick_v2/core/utils/api_constants.dart';
import 'package:universo_rick_v2/features/characters/data/moldels/character_model.dart';

abstract class ICharacterRemoteDatasource {
  Future<List<CharacterModel>> getAllCharacters();
}

class CharacterRemoteDatasourceImpl implements ICharacterRemoteDatasource {
  final Dio dio;
  CharacterRemoteDatasourceImpl(this.dio);
  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      final response = await dio.get(ApiConstants.characterEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'] as List<dynamic>;
        return results.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        throw Exception('Falha ao carregar personagens');
      }
    } catch (e) {
      throw Exception('Falha ao carregar personagens: $e');
    }
  }
}
