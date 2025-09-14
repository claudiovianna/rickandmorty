import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:universo_rick_v2/core/design_system/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Universo Rick',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
