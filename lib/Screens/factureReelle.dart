import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_final/Components/MyDrawer.dart';
import 'package:projet_final/Models/facture_model.dart';

// Palette de l'écran
const Color _primaire = Color(0xFF334155); // bleu ardoise
const Color _accent = Color(0xFF14B8A6); // turquoise
const Color _fond = Color(0xFFF8FAFC); // blanc cassé
const Color _texte = Color(0xFF1E293B);
const Color _texteSecondaire = Color(0xFF64748B);

class FactureReelle extends StatefulWidget {
  const FactureReelle({super.key});

  @override
  State<FactureReelle> createState() => _FactureReelleState();
}

class _FactureReelleState extends State<FactureReelle> {
  final TextEditingController saisitAncienIndice = TextEditingController();
  final TextEditingController saisitNouvelIndice = TextEditingController();
  double consommation = 0.0;
  double prix = 0.0;
  double tauxTaxes = 0.34;
  bool resultatDisponible = false;

  void calcul() {
    if (saisitAncienIndice.text.trim().isEmpty ||
        saisitNouvelIndice.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir les deux champs.")),
      );
      return;
    }

    double? ancien = double.tryParse(saisitAncienIndice.text.trim());
    double? nouveau = double.tryParse(saisitNouvelIndice.text.trim());

    if (ancien == null || nouveau == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Merci de saisir uniquement des chiffres.")),
      );
      return;
    }

    if (ancien < 0 || nouveau < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Les indices ne peuvent pas être négatifs.")),
      );
      return;
    }

    if (nouveau < ancien) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le nouvel indice doit être supérieur à l'ancien indice.")),
      );
      return;
    }

    setState(() {
      consommation = nouveau - ancien;

      if (consommation <= 100) {
        prix = consommation * 0.9;
      } else if (consommation > 100 && consommation <= 200) {
        prix = (100 * 0.9) + ((consommation - 100) * 1.10);
      } else {
        prix = (100 * 0.9) + (100 * 1.10) + ((consommation - 200) * 1.30);
      }

      double montantEnergie = prix;
      prix = montantEnergie + (montantEnergie * tauxTaxes);
      resultatDisponible = true;
    });
  }

  void enregistrerFacture() {
    var box = Hive.box<Facture>('factures');
    Facture nouvelleFacture = Facture(
      date: DateTime.now(),
      consommation: consommation,
      prix: prix,
    );
    box.add(nouvelleFacture);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Facture enregistrée avec succès.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fond,
      appBar: AppBar(
        title: const Text("Facture Réelle"),
        backgroundColor: _primaire,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bandeau d'en-tête avec icône, remplace le texte flottant
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
              decoration: const BoxDecoration(
                color: _primaire,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _accent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.speed, color: _accent, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      "Relevé du compteur",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Formulaire de saisie
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _champTexte("Ancien indice (kWh)", saisitAncienIndice),
                  const SizedBox(height: 16),
                  _champTexte("Nouvel indice (kWh)", saisitNouvelIndice),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: calcul,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Calculer la facture",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Carte résultat, affichée seulement après un calcul
                  if (resultatDisponible) _carteResultat(),

                  if (resultatDisponible) const SizedBox(height: 16),

                  if (resultatDisponible)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: enregistrerFacture,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _primaire,
                          side: const BorderSide(color: _primaire, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Enregistrer cette facture",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        ),
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

  // Widget réutilisable pour un champ de saisie stylé
  Widget _champTexte(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: _texte),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: _texteSecondaire),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _accent, width: 1.5),
        ),
      ),
    );
  }

  // Carte de résultat détaillée
  Widget _carteResultat() {
    double energie = prix / (1 + tauxTaxes);
    double taxes = prix - energie;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${consommation.toStringAsFixed(2)} kWh',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _texte,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Consommation estimée",
            style: TextStyle(fontSize: 13, color: _texteSecondaire),
          ),
          const Divider(height: 28),
          _ligneDetail("Énergie", energie),
          const SizedBox(height: 8),
          _ligneDetail("Taxes (${(tauxTaxes * 100).toStringAsFixed(0)}%)", taxes),
          const Divider(height: 28),
          _ligneDetail("Total", prix, accent: true),
        ],
      ),
    );
  }

  Widget _ligneDetail(String label, double valeur, {bool accent = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: accent ? 16 : 14,
            fontWeight: accent ? FontWeight.bold : FontWeight.normal,
            color: accent ? _texte : _texteSecondaire,
          ),
        ),
        Text(
          '${valeur.toStringAsFixed(2)} dh',
          style: TextStyle(
            fontSize: accent ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: accent ? _accent : _texte,
          ),
        ),
      ],
    );
  }
}