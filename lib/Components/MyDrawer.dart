import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_final/Components/itemMenu.dart';
import 'package:projet_final/Models/utilisateur_model.dart';

Drawer MyDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color(0xFFF8FAFC),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // ValueListenableBuilder : le header se met à jour automatiquement
        // dès que le profil est enregistré/modifié, sans redémarrer l'app
        ValueListenableBuilder(
          valueListenable: Hive.box<Utilisateur>('utilisateur').listenable(),
          builder: (context, Box<Utilisateur> box, _) {
            String nom = "Invité";
            String sousTitre = "Aucun profil créé";
            String initiales = "?";

            if (box.isNotEmpty) {
              Utilisateur u = box.getAt(0)!;
              nom = u.nom;
              sousTitre = u.email;
              List<String> mots = u.nom.trim().split(" ");
              initiales = mots.length == 1
                  ? mots[0][0].toUpperCase()
                  : (mots[0][0] + mots[1][0]).toUpperCase();
            }

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: const BoxDecoration(color: Color(0xFF334155)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF14B8A6),
                    child: Text(
                      initiales,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    nom,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sousTitre,
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        itemMenu(
          icon: Icons.speed_outlined,
          titre: "Facture réelle",
          goto: () => Navigator.of(context).popAndPushNamed("/factureReelle"),
        ),
        itemMenu(
          icon: Icons.history,
          titre: "Historique",
          goto: () => Navigator.of(context).popAndPushNamed("/historique"),
        ),
        itemMenu(
          icon: Icons.account_circle_outlined,
          titre: "Profil utilisateur",
          goto: () => Navigator.of(context).popAndPushNamed("/profil"),
        ),
      ],
    ),
  );
}