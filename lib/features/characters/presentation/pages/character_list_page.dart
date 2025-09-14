import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:universo_rick_v2/core/design_system/app_text_styles.dart';
import 'package:universo_rick_v2/features/characters/presentation/stores/character_store.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  final store = Modular.get<CharacterStore>();

  @override
  void initState() {
    super.initState();
    store.getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0),
            child: Icon(Icons.exit_to_app),
          ),
          tooltip: 'Fechar',
          onPressed: () {
            exit(0);
          },
        ),
        title: const Text(
          'Personagens Rick and Morty',
          style: AppTextStyles.bodyLargeBold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recarregar',
            onPressed: store.getAllCharacters,
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(store.errorMessage!, style: AppTextStyles.bodyLarge),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: store.getAllCharacters,
                    child: const Text('Tente Novamente'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 8.0,
              right: 8.0,
              bottom: 10.0,
            ),
            child: ListView.builder(
              itemCount: store.characters.length,
              itemBuilder: (context, index) {
                final character = store.characters[index];
                return ListTile(
                  leading: Image.network(character.image),
                  title: Text(character.name, style: AppTextStyles.bodyMedium),
                  subtitle: Text(
                    character.species == 'Human'
                        ? 'Humano'
                        : character.species == 'Alien'
                        ? 'Alienígena'
                        : character.species,
                    style: AppTextStyles.caption,
                  ),
                  trailing: Text(
                    character.status == 'Alive'
                        ? 'vivo'
                        : character.status == 'Dead'
                        ? 'morto'
                        : character.status == 'unknown'
                        ? 'desconhecido'
                        : character.status,
                    style: AppTextStyles.subCaption,
                  ),
                  onTap: () {
                    Modular.to.pushNamed(
                      '/characters/details',
                      arguments: character,
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
