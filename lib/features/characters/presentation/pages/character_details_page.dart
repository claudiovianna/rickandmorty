import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:universo_rick_v2/core/design_system/app_colors.dart';
import 'package:universo_rick_v2/core/design_system/app_text_styles.dart';
import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';
import 'package:universo_rick_v2/features/characters/presentation/widgets/character_detail_row.dart';

class CharacterDetailsPage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterDetailsPage({super.key, required this.character});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.statusAlive;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name, style: AppTextStyles.heading2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(character.name, style: AppTextStyles.heading2),
            const SizedBox(height: 16),
            Card(
              color: _getStatusColor(character.status).withValues(alpha: 30),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  children: [
                    CharacterDetailRow(
                      label: 'Status',
                      value: character.status,
                    ),
                    const Divider(color: AppColors.primary),
                    CharacterDetailRow(
                      label: 'Espécie',
                      value: character.species,
                    ),
                    CharacterDetailRow(
                      label: 'Gênero',
                      value: character.gender,
                    ),
                    CharacterDetailRow(
                      label: 'Origem',
                      value: character.origin,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
