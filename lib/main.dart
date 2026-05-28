import 'package:flutter/material.dart';
import 'package:projet_final/Screens/calculFacture.dart';
import 'package:projet_final/Screens/profilUtilisateur.dart';
import 'package:projet_final/Screens/appareilElectrique.dart';
 
void main() {
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
        "/": (BuildContext context) =>  calculFacture(),
        "/profil": (BuildContext context) =>  profilUtilisateur(),
        "/appElectric": (BuildContext context) => AppareilElectrique(),
      },
    );
  }
}
