import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;
import 'package:mobx/mobx.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/presentation/pages/character_list_page.dart';
import 'package:universo_rick_v2/features/characters/presentation/stores/character_store.dart';

import 'character_list_page_test.mocks.dart';

@GenerateMocks([CharacterStore])
void main() {
  late MockCharacterStore mockStore;

  setUp(() {
    mockStore = MockCharacterStore();
    Modular.bindModule(TestModule(mockStore));
  });

  tearDown(() {
    Modular.destroy();
  });

  group('CharacterListPage', () {
    testWidgets('should display loading indicator when isLoading is true',
        (tester) async {
      // Arrange
      mockito.when(mockStore.isLoading).thenReturn(true);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Personagens Rick and Morty'), findsOneWidget);
    });

    testWidgets('should display error message when errorMessage is not null',
        (tester) async {
      // Arrange
      const errorMsg = 'Falha ao carregar personagens. Tente novamente';
      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(errorMsg);
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));

      // Assert
      expect(find.text(errorMsg), findsOneWidget);
      expect(find.text('Tente Novamente'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should call getAllCharacters when retry button is pressed',
        (tester) async {
      // Arrange
      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn('Error');
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));
      await tester.tap(find.text('Tente Novamente'));

      // Assert
      mockito.verify(mockStore.getAllCharacters()).called(2); // initState + retry
    });

    testWidgets('should display character list when data is loaded',
        (tester) async {
      // Arrange
      final characters = ObservableList<CharacterEntity>.of([
        CharacterEntity(
          id: 1,
          name: 'Rick Sanchez',
          image: 'https://example.com/rick.jpg',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
        CharacterEntity(
          id: 2,
          name: 'Morty Smith',
          image: 'https://example.com/morty.jpg',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
      ]);

      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(characters);

      // Act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const TestApp(child: CharacterListPage()));
      });

      // Assert
      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Morty Smith'), findsOneWidget);
      expect(find.text('Humano'), findsNWidgets(2));
      expect(find.text('vivo'), findsNWidgets(2));
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('should translate species correctly', (tester) async {
      // Arrange
      final characters = ObservableList<CharacterEntity>.of([
        CharacterEntity(
          id: 1,
          name: 'Alien Character',
          image: 'https://example.com/alien.jpg',
          status: 'Alive',
          species: 'Alien',
          gender: 'Male',
          origin: 'Space',
        ),
      ]);

      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(characters);

      // Act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const TestApp(child: CharacterListPage()));
      });

      // Assert
      expect(find.text('Alienígena'), findsOneWidget);
    });

    testWidgets('should translate status correctly', (tester) async {
      // Arrange
      final characters = ObservableList<CharacterEntity>.of([
        CharacterEntity(
          id: 1,
          name: 'Dead Character',
          image: 'https://example.com/dead.jpg',
          status: 'Dead',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
        CharacterEntity(
          id: 2,
          name: 'Unknown Character',
          image: 'https://example.com/unknown.jpg',
          status: 'unknown',
          species: 'Human',
          gender: 'Male',
          origin: 'Earth',
        ),
      ]);

      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(characters);

      // Act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const TestApp(child: CharacterListPage()));
      });

      // Assert
      expect(find.text('morto'), findsOneWidget);
      expect(find.text('desconhecido'), findsOneWidget);
    });

    testWidgets('should call getAllCharacters when refresh button is pressed',
        (tester) async {
      // Arrange
      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));
      await tester.tap(find.byIcon(Icons.refresh));

      // Assert
      mockito.verify(mockStore.getAllCharacters()).called(2); // initState + refresh
    });

    testWidgets('should display character list tile correctly',
        (tester) async {
      // Arrange
      final character = CharacterEntity(
        id: 1,
        name: 'Rick Sanchez',
        image: 'https://example.com/rick.jpg',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        origin: 'Earth',
      );

      final characters = ObservableList<CharacterEntity>.of([character]);

      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(characters);

      // Act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(const TestApp(child: CharacterListPage()));
      });

      // Assert
      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('should call getAllCharacters on initState', (tester) async {
      // Arrange
      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));

      // Assert
      mockito.verify(mockStore.getAllCharacters()).called(1);
    });

    testWidgets('should display correct app bar elements', (tester) async {
      // Arrange
      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));

      // Assert
      expect(find.text('Personagens Rick and Morty'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
      expect(find.byIcon(Icons.exit_to_app), findsOneWidget);
    });

    testWidgets('should have exit button in app bar', (tester) async {
      // Arrange
      mockito.when(mockStore.isLoading).thenReturn(false);
      mockito.when(mockStore.errorMessage).thenReturn(null);
      mockito.when(mockStore.characters).thenReturn(ObservableList<CharacterEntity>());

      // Act
      await tester.pumpWidget(const TestApp(child: CharacterListPage()));

      // Assert
      expect(find.byIcon(Icons.exit_to_app), findsOneWidget);
      expect(find.byTooltip('Fechar'), findsOneWidget);
    });
  });
}

class TestModule extends Module {
  final CharacterStore characterStore;

  TestModule(this.characterStore);

  @override
  void binds(Injector i) {
    i.addSingleton<CharacterStore>(() => characterStore);
  }
}

class TestApp extends StatelessWidget {
  final Widget child;

  const TestApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: TestModule(Modular.get<CharacterStore>()),
      child: MaterialApp(
        home: child,
      ),
    );
  }
}