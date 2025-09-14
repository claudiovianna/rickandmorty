import 'package:mobx/mobx.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/domain/usecases/get_all_characters.dart';

part 'character_store.g.dart';

class CharacterStore = CharacterStoreBase with _$CharacterStore;

abstract class CharacterStoreBase with Store {
  final GetAllCharacters _getAllCharacters;

  CharacterStoreBase(this._getAllCharacters);

  @observable
  ObservableList<CharacterEntity> characters =
      ObservableList<CharacterEntity>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> getAllCharacters() async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await _getAllCharacters();
      characters.clear();
      characters.addAll(result);
    } catch (e) {
      errorMessage = 'Falha ao carregar personagens. Tente novamente';
    } finally {
      isLoading = false;
    }
  }
}
