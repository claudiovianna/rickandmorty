// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharacterStore on CharacterStoreBase, Store {
  late final _$charactersAtom = Atom(
    name: 'CharacterStoreBase.characters',
    context: context,
  );

  @override
  ObservableList<CharacterEntity> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<CharacterEntity> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: 'CharacterStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'CharacterStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getAllCharactersAsyncAction = AsyncAction(
    'CharacterStoreBase.getAllCharacters',
    context: context,
  );

  @override
  Future<void> getAllCharacters() {
    return _$getAllCharactersAsyncAction.run(() => super.getAllCharacters());
  }

  @override
  String toString() {
    return '''
characters: ${characters},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
