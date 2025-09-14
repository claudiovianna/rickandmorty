import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:universo_rick_v2/app/app_module.dart';
import 'package:universo_rick_v2/features/splash/presentation/splash_page.dart';

// Mock para o Modular Navigator
class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  late ModularNavigateMock navigatorMock;

  setUp(() {
    Modular.init(AppModule());
    navigatorMock = ModularNavigateMock();
    Modular.replaceInstance<IModularNavigator>(navigatorMock);
  });

  tearDown(() {
    Modular.destroy();
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(home: SplashPage());
  }

  group('SplashPage', () {
    testWidgets('deve renderizar os widgets corretamente na tela', (
      tester,
    ) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.text('Rick and Morty'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      });
    });

    // testWidgets('deve navegar para a rota /characters após 3 segundos', (
    //   tester,
    // ) async {
    //   await tester.runAsync(() async {
    //     await tester.pumpWidget(createWidgetUnderTest());
    //     await tester.pump(const Duration(seconds: 20));
    //     // Remova o pumpAndSettle
    //     verify(navigatorMock.navigate('/characters')).called(1);
    //   });
    // });
  });
}
