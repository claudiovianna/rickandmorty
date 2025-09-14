import 'package:universo_rick_v2/features/characters/domain/entities/character_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel({
    required super.id,
    required super.name,
    required super.image,
    required super.status,
    required super.species,
    required super.gender,
    required super.origin,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      origin: json['origin']['name'] ?? 'desconhecida',
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      image: image,
      status: status,
      species: species,
      gender: gender,
      origin: origin,
    );
  }
}
