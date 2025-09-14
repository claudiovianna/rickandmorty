import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:universo_rick_v2/core/services/dio_client.dart';
import 'package:universo_rick_v2/features/characters/data/datasources/character_remote_datasource.dart';
import 'package:universo_rick_v2/features/characters/data/repositories/character_repository_impl.dart';
import 'package:universo_rick_v2/features/characters/domain/repositories/character_repository.dart';
import 'package:universo_rick_v2/features/characters/domain/usecases/get_all_characters.dart';
import 'package:universo_rick_v2/features/characters/presentation/pages/character_details_page.dart';
import 'package:universo_rick_v2/features/characters/presentation/pages/character_list_page.dart';
import 'package:universo_rick_v2/features/characters/presentation/stores/character_store.dart';
import 'package:universo_rick_v2/features/splash/presentation/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Core
    i.addSingleton(() => Dio());
    i.addSingleton(() => DioClient(i.get<Dio>()));

    // Data
    i.addSingleton<ICharacterRemoteDatasource>(
      CharacterRemoteDatasourceImpl.new,
    );
    i.addSingleton<ICharacterRepository>(CharacterRepositoryImpl.new);

    // Domain
    i.addSingleton(() => GetAllCharacters(i.get<ICharacterRepository>()));

    // Presentation
    i.addSingleton(() => CharacterStore(i.get<GetAllCharacters>()));
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const SplashPage());
    r.child('/characters/', child: (_) => const CharacterListPage());
    r.child(
      '/characters/details',
      child: (_) => CharacterDetailsPage(character: r.args.data),
    );
  }
}
