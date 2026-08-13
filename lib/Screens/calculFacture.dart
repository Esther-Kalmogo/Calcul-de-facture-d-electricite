import 'package:flutter/material.dart';
import 'package:projet_final/Components/MyDrawer.dart'; 
import 'package:projet_final/Models/facture_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
 

class calculFacture extends StatefulWidget {
  const calculFacture({super.key});
 
  @override
  State<calculFacture> createState() => _calculFactureState();
}
 
class _calculFactureState extends State<calculFacture> {
  final TextEditingController saisitPuissance = TextEditingController();
  final TextEditingController saisitHeures = TextEditingController();
  final TextEditingController saisitJours = TextEditingController();
  double consommation = 0.0;
  double prix = 0.0;
 
  
  void calcul() {
    setState(() {
      double puissance = double.tryParse(saisitPuissance.text) ?? 0.0;
      double heures = double.tryParse(saisitHeures.text) ?? 0.0;
      double jours = double.tryParse(saisitJours.text) ?? 0.0;
      consommation = (puissance * heures * jours) / 1000;

      //Calcul du prix de la consommation
      if (consommation <= 100) {
        prix = consommation * 0.9; // Tarif de 0,9 dh/kWh pour les 100 premiers kWh
      } else  if (consommation > 100 && consommation <= 200) {
        prix = (100 * 0.9)  + ((consommation - 100) * 1.10);
      } else{
        prix = (100 * 0.9) + (100 * 1.10) + ((consommation - 200) * 1.30);
      }
    });
  }

  void enregistrerFacture() {
    // On récupère la boîte déjà ouverte dans main.dart
    final box =  Hive.box<Facture>('factures');
    // On crée un nouvel objet Facture avec les valeurs déjà calculées
    Facture nouvelleFacture = Facture(
      date: DateTime.now(),
      consommation: consommation,
      prix: prix,
    );
    //
    box.add(nouvelleFacture);

    print('Facture enregistrée : ${nouvelleFacture.consommation} kWh, ${nouvelleFacture.prix} dh, le ${nouvelleFacture.date}');
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calcul Facture"),
        backgroundColor: const Color.fromRGBO(170, 6, 133, 1.0),
      ),
      drawer: MyDrawer(context), 
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text(
              "SIMULATEUR DE CONSOMMATION",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: saisitPuissance,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Puissance (W)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: saisitHeures,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Heures (h)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: saisitJours,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jours',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calcul, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Calculer la consommation",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: enregistrerFacture, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(170, 6, 133, 1.0),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Enregistrer la facture",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Column(
                children: [
                  const Text(
                    "Résultat :",
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${consommation.toStringAsFixed(2)} kWh',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${prix.toStringAsFixed(2)} dh',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
