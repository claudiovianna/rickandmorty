import 'package:flutter/material.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';
import 'package:universo_rick_v2/core/design_system/app_text_styles.dart';

class CharacterDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const CharacterDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyLarge),
          _InformationData(value: value, color: color),
        ],
      ),
    );
  }
}

class _InformationData extends StatelessWidget {
  final String value;
  final Color? color;

  const _InformationData({required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      value == 'Human'
          ? 'Humano'
          : value == 'Alien'
          ? 'Alienígena'
          : value == 'Alive'
          ? 'vivo'
          : value == 'Dead'
          ? 'morto'
          : value == 'unknown'
          ? 'desconhecido'
          : value == 'Earth (Replacement Dimension)'
          ? 'Terra'
          : value == 'Male'
          ? 'Masculino'
          : value == 'Female'
          ? 'Feminino'
          : value,
      style: AppTextStyles.bodyMedium.copyWith(
        color: color ?? AppColors.textPrimary,
      ),
    );
  }
}
