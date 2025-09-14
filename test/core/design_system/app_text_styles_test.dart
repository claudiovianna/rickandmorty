import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';
import 'package:universo_rick_v2/core/design_system/app_text_styles.dart';

void main() {
  test('AppTextStyles possui os valores esperados', () {
    expect(
      AppTextStyles.heading1,
      const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );

    expect(
      AppTextStyles.heading2,
      const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );

    expect(
      AppTextStyles.bodyLarge,
      const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      ),
    );

    expect(
      AppTextStyles.bodyLargeBold,
      const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
      ),
    );

    expect(
      AppTextStyles.bodyMedium,
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );

    expect(
      AppTextStyles.caption,
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );

    expect(
      AppTextStyles.subCaption,
      const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  });
}
