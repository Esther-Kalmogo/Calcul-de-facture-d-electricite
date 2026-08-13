import 'package:flutter/material.dart';
import 'package:projet_final/Screens/calculFacture.dart';
import 'package:projet_final/Screens/profilUtilisateur.dart';
import 'package:projet_final/Screens/appareilElectrique.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_final/Models/facture_model.dart';
import 'package:projet_final/Screens/factureReelle.dart';
import 'package:projet_final/Screens/historique.dart';
import 'package:projet_final/Models/utilisateur_model.dart';
 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FactureAdapter());
  await Hive.openBox<Facture>('factures');
  Hive.registerAdapter(UtilisateurAdapter());
  await Hive.openBox<Utilisateur>('utilisateur');
  runApp(const MyApp());
}

 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/", 
      routes: {
        "/": (BuildContext context) =>  FactureReelle(),
        "/profil": (BuildContext context) =>  ProfilUtilisateur(),
        "/appElectric": (BuildContext context) => AppareilElectrique(),
        "/factureReelle": (BuildContext context) => FactureReelle(),
        "/historique": (BuildContext context) => Historique(),
      },
    );
  }
}
