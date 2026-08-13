import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projet_final/Components/MyDrawer.dart';
import 'package:projet_final/Models/utilisateur_model.dart';



const Color _primaire = Color(0xFF334155);
const Color _accent = Color(0xFF14B8A6);
const Color _fond = Color(0xFFF8FAFC);
const Color _texte = Color(0xFF1E293B);
const Color _texteSecondaire = Color(0xFF64748B);

class ProfilUtilisateur extends StatefulWidget {
  const ProfilUtilisateur({super.key});

  @override
  State<ProfilUtilisateur> createState() => _ProfilUtilisateurState();
}

class _ProfilUtilisateurState extends State<ProfilUtilisateur> {
  final TextEditingController saisitNom = TextEditingController();
  final TextEditingController saisitEmail = TextEditingController();
  final TextEditingController saisitVille = TextEditingController();

  @override
  void initState() {
    super.initState();
    chargerProfilExistant();
  }

  // Si un profil existe déjà, on pré-remplit les champs pour permettre la modification
  void chargerProfilExistant() {
    var box = Hive.box<Utilisateur>('utilisateur');
    if (box.isNotEmpty) {
      Utilisateur u = box.getAt(0)!;
      saisitNom.text = u.nom;
      saisitEmail.text = u.email;
      saisitVille.text = u.ville;
    }
  }

  void enregistrerProfil() {
    if (saisitNom.text.trim().isEmpty || saisitEmail.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Le nom et l'email sont obligatoires.")),
      );
      return;
    }

    // Validation simple d'email : présence d'un @ et d'un point après
    if (!saisitEmail.text.contains('@') || !saisitEmail.text.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Merci de saisir un email valide.")),
      );
      return;
    }

    var box = Hive.box<Utilisateur>('utilisateur');

    Utilisateur nouveauProfil = Utilisateur(
      nom: saisitNom.text.trim(),
      email: saisitEmail.text.trim(),
      ville: saisitVille.text.trim(),
    );

    if (box.isEmpty) {
      box.add(nouveauProfil);
    } else {
      // Un profil existe déjà : on le remplace au lieu d'en créer un deuxième
      box.putAt(0, nouveauProfil);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil enregistré avec succès.")),
    );

    setState(() {}); // pour rafraîchir l'avatar avec les nouvelles initiales
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fond,
      appBar: AppBar(
        title: const Text("Profil utilisateur"),
        backgroundColor: _primaire,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: MyDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bandeau avatar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: _primaire,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: _accent,
                    child: Text(
                      _initiales(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    saisitNom.text.isEmpty ? "Nouvel utilisateur" : saisitNom.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Formulaire
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vos informations",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _texte,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _champTexte("Nom complet", saisitNom, Icons.person_outline),
                  const SizedBox(height: 16),
                  _champTexte("Email", saisitEmail, Icons.email_outlined),
                  const SizedBox(height: 16),
                  _champTexte("Ville", saisitVille, Icons.location_on_outlined),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: enregistrerProfil,
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
                        "Enregistrer le profil",
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

  // Récupère les initiales à partir du nom saisi, pour l'avatar
  String _initiales() {
    if (saisitNom.text.trim().isEmpty) return "?";
    List<String> mots = saisitNom.text.trim().split(" ");
    if (mots.length == 1) return mots[0][0].toUpperCase();
    return (mots[0][0] + mots[1][0]).toUpperCase();
  }

  Widget _champTexte(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: _texte),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: _texteSecondaire),
        prefixIcon: Icon(icon, color: _texteSecondaire, size: 20),
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
}