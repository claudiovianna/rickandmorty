import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';

void main() {
  test('AppColors possui os valores esperados', () {
    expect(AppColors.primary, const Color(0xFF263238));
    expect(AppColors.secondary, const Color(0xFF455A64));
    expect(AppColors.accent, const Color(0xFF00ACC1));
    expect(AppColors.background, const Color(0xFFECEFF1));
    expect(AppColors.textPrimary, Colors.white);
    expect(AppColors.textSecondary, const Color(0xFFCFD8DC));
    expect(AppColors.statusAlive, const Color(0xFF4CAF50));
    expect(AppColors.statusDead, const Color(0xFFF44336));
    expect(AppColors.statusUnknown, const Color(0xFF9E9E9E));
  });
}
