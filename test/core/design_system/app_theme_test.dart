import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';
import 'package:universo_rick_v2/core/design_system/app_theme.dart';

void main() {
  test('AppTheme.theme possui os valores esperados', () {
    final theme = AppTheme.theme;

    expect(theme.primaryColor, AppColors.primary);
    expect(theme.scaffoldBackgroundColor, AppColors.primary);

    final colorScheme = theme.colorScheme;
    expect(colorScheme.primary, AppColors.accent);
    expect(colorScheme.secondary, AppColors.secondary);
    expect(colorScheme.surface, AppColors.primary);

    final appBarTheme = theme.appBarTheme;
    expect(appBarTheme.backgroundColor, AppColors.secondary);
    expect(appBarTheme.elevation, 4);
    expect(appBarTheme.centerTitle, true);

    final cardTheme = theme.cardTheme;
    expect(cardTheme.color, AppColors.secondary);
    expect(cardTheme.elevation, 2);
    expect(cardTheme.shape, isA<RoundedRectangleBorder>());
  });
}
