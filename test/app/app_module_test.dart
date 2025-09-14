import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/app/app_module.dart';
import 'package:universo_rick_v2/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:universo_rick_v2/features/characters/data/repositories/character_repository_impl.dart';
import 'package:universo_rick_v2/features/characters/domain/repositories/character_repository.dart';
import 'package:universo_rick_v2/features/characters/domain/usecases/get_all_characters.dart';
import 'package:universo_rick_v2/features/characters/presentation/stores/character_store.dart';

void main() {
  late AppModule appModule;
  setUpAll(() {
    appModule = AppModule();
    Modular.bindModule(appModule);
  });

  test('Deve registrar CharacterRemoteDatasourceImpl como singleton', () {
    final datasource = Modular.get<ICharacterRemoteDatasource>();
    expect(datasource, isA<ICharacterRemoteDatasource>());
  });

  test('Deve registrar CharacterRepositoryImpl como singleton', () {
    final repository = Modular.get<ICharacterRepository>();
    expect(repository, isA<CharacterRepositoryImpl>());
  });

  test('Deve registrar GetAllCharacters como singleton', () {
    final usecase = Modular.get<GetAllCharacters>();
    expect(usecase, isA<GetAllCharacters>());
  });

  test('Deve registrar CharacterStore como singleton', () {
    final store = Modular.get<CharacterStore>();
    expect(store, isA<CharacterStore>());
  });
}
