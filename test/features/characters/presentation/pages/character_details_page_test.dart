import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/presentation/pages/character_details_page.dart';
import 'package:universo_rick_v2/features/characters/presentation/widgets/character_detail_row.dart';

void main() {
  // ARRANGE (Organizar)
  // Criamos instâncias de CharacterEntity para cobrir os diferentes cenários de status.
  final tCharacterAlive = CharacterEntity(
    id: 1,
    name: 'Rick Sanchez',
    image: 'image_url',
    status: 'Alive',
    species: 'Human',
    gender: 'Male',
    origin: 'Earth (C-137)',
  );

  // final tCharacterDead = CharacterEntity(
  //   id: 2,
  //   name: 'Birdperson',
  //   image: 'image_url',
  //   status: 'Dead',
  //   species: 'Bird-Person',
  //   gender: 'Male',
  //   origin: 'Bird World',
  // );

  // final tCharacterUnknown = CharacterEntity(
  //   id: 3,
  //   name: 'Gloopie',
  //   image: 'image_url',
  //   status: 'unknown',
  //   species: 'Gloopie',
  //   gender: 'Genderless',
  //   origin: 'unknown',
  // );

  // Função helper para criar o widget sob teste dentro de um MaterialApp.
  // Isso é necessário para que widgets como Scaffold e AppBar funcionem.
  Widget createWidgetUnderTest(CharacterEntity character) {
    return MaterialApp(home: CharacterDetailsPage(character: character));
  }

  group('CharacterDetailsPage', () {
    testWidgets('deve renderizar todos os detalhes do personagem corretamente', (
      WidgetTester tester,
    ) async {
      // Usamos mockNetworkImagesFor para interceptar as chamadas de imagem.
      await mockNetworkImagesFor(() async {
        // ACT (Agir)
        // Renderizamos o widget na tela de teste.
        await tester.pumpWidget(createWidgetUnderTest(tCharacterAlive));

        // ASSERT (Verificar)
        // Verificamos se o nome do personagem aparece 2 vezes (AppBar e corpo).
        expect(find.text('Rick Sanchez'), findsNWidgets(2));

        // Verificamos se o widget da imagem foi renderizado.
        expect(find.byType(CachedNetworkImage), findsOneWidget);

        // Verificamos se todos os detalhes estão na tela.
        // O finder `widgetWithText` é ótimo para encontrar um widget pai pelo texto de um filho.
        expect(
          find.widgetWithText(CharacterDetailRow, 'Status'),
          findsOneWidget,
        );
        // expect(find.text('Alive'), findsOneWidget);
        expect(find.text('vivo'), findsOneWidget);

        expect(
          find.widgetWithText(CharacterDetailRow, 'Espécie'),
          findsOneWidget,
        );
        expect(find.text('Humano'), findsOneWidget);

        expect(
          find.widgetWithText(CharacterDetailRow, 'Gênero'),
          findsOneWidget,
        );
        expect(find.text('Masculino'), findsOneWidget);

        expect(
          find.widgetWithText(CharacterDetailRow, 'Origem'),
          findsOneWidget,
        );
        expect(find.text('Earth (C-137)'), findsOneWidget);
      });
    });

    // group('Lógica de cor do status', () {
    //   // Nota: O método `withValues` não existe na classe Color.
    //   // O correto seria `withAlpha`. O teste abaixo assume que o código foi corrigido para `withAlpha(30)`.

    //   testWidgets('deve mostrar a cor verde para o status "Alive"', (
    //     WidgetTester tester,
    //   ) async {
    //     await mockNetworkImagesFor(() async {
    //       await tester.pumpWidget(createWidgetUnderTest(tCharacterAlive));

    //       // Encontramos o widget Card na árvore de widgets.
    //       final card = tester.widget<Card>(find.byType(Card));

    //       // Verificamos se a cor do Card está correta.
    //       expect(card.color, Colors.green.withAlpha(30));
    //     });
    //   });

    //   testWidgets('deve mostrar a cor vermelha para o status "Dead"', (
    //     WidgetTester tester,
    //   ) async {
    //     await mockNetworkImagesFor(() async {
    //       await tester.pumpWidget(createWidgetUnderTest(tCharacterDead));

    //       final card = tester.widget<Card>(find.byType(Card));
    //       expect(card.color, Colors.red.withAlpha(30));
    //     });
    //   });

    //   testWidgets('deve mostrar a cor cinza para o status "unknown"', (
    //     WidgetTester tester,
    //   ) async {
    //     await mockNetworkImagesFor(() async {
    //       await tester.pumpWidget(createWidgetUnderTest(tCharacterUnknown));

    //       final card = tester.widget<Card>(find.byType(Card));
    //       expect(card.color, Colors.grey.withAlpha(30));
    //     });
    //   });
    // });
  });
}
