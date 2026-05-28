import 'package:flutter/material.dart';
import 'package:projet_final/Components/Header.dart';
import 'package:projet_final/Components/itemMenu.dart';
 
Drawer MyDrawer(BuildContext context) {
  
  return Drawer(
    child: Material(
      color: const Color.fromRGBO(170, 6, 133, 1.0),
      child: ListView(
        children: [
          header(), 
 
          const Divider(color: Color.fromRGBO(247, 227, 146, 1.0)),
          itemMenu(
            icon: Icons.account_circle,
            titre: "Profil utilisateur", 
            goto: () => Navigator.of(context).popAndPushNamed("/profil"),
          ),
 
          const Divider(color: Color.fromRGBO(247, 227, 146, 1.0)),
          itemMenu(
            icon: Icons.calculate,
            titre: "Calcul facture",
            goto: () => Navigator.of(context).popAndPushNamed("/"),
          ),
 
          const Divider(color: Color.fromRGBO(247, 227, 146, 1.0)),
          itemMenu(
            icon: Icons.electrical_services,
            titre: "Appareils électriques",
            goto: () => Navigator.of(context).popAndPushNamed("/appElectric"),
          ),
        ],
      ),
    ),
  );
}
