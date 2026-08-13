import 'package:hive/hive.dart';//donne acces aux outils de la Hive

part 'facture_model.g.dart';// relier ce fichier a la classe facture_model.g.dart qui est genere automatiquement par la Hive pour stocker les donnees de la facture dans la base de donnees 

@HiveType(typeId: 0)
class Facture extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  double consommation;

  @HiveField(2)
  double prix;

  Facture({
    required this.date,
    required this.consommation,
    required this.prix,
  });
}

//definir la forme de la facture pour que la Hive puisse la stocker dans la base de données meme apres fermeture de l'application;