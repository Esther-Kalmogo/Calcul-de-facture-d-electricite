import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_final/Components/MyDrawer.dart';
import 'package:projet_final/Models/facture_model.dart';

const Color _primaire = Color(0xFF334155);
const Color _accent = Color(0xFF14B8A6);
const Color _fond = Color(0xFFF8FAFC);
const Color _texte = Color(0xFF1E293B);
const Color _texteSecondaire = Color(0xFF64748B);

class Historique extends StatelessWidget {
  const Historique({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fond,
      appBar: AppBar(
        title: const Text("Historique"),
        backgroundColor: _primaire,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(context),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Facture>('factures').listenable(),
        builder: (context, Box<Facture> box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text(
                "Aucune facture enregistrée pour l'instant.",
                style: TextStyle(fontSize: 15, color: _texteSecondaire),
              ),
            );
          }

          List<Facture> factures = box.values.toList();
          factures.sort((a, b) => b.date.compareTo(a.date));

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: factures.length,
            itemBuilder: (context, index) {
              Facture f = factures[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.receipt_long, color: _accent),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${f.consommation.toStringAsFixed(2)} kWh',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: _texte,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${f.date.day}/${f.date.month}/${f.date.year} à ${f.date.hour}:${f.date.minute.toString().padLeft(2, '0')}',
                            style: const TextStyle(fontSize: 12, color: _texteSecondaire),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${f.prix.toStringAsFixed(2)} dh',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: _accent,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}