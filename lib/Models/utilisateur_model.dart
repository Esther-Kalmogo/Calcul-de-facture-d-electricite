import 'package:hive/hive.dart';

part 'utilisateur_model.g.dart';

@HiveType(typeId: 1) // 1 car Facture utilise déjà typeId 0
class Utilisateur extends HiveObject {
  @HiveField(0)
  String nom;

  @HiveField(1)
  String email;

  @HiveField(2)
  String ville;

  Utilisateur({
    required this.nom,
    required this.email,
    required this.ville,
  });
}