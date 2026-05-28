import 'package:flutter/material.dart';
import 'package:projet_final/Components/MyDrawer.dart';
 
class profilUtilisateur extends StatelessWidget {
  const profilUtilisateur({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profil Utilisateur",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(170, 6, 133, 1.0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            const CircleAvatar(
              radius: 48,
              backgroundColor: Color.fromRGBO(234, 108, 238, 0.2),
              child: Text(
                "FD",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(170, 6, 133, 1.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
 
            
            const Text(
              "Frédéric Dupont",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            const SizedBox(height: 6),
 
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(234, 108, 238, 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Utilisateur Standard",
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromRGBO(170, 6, 133, 1.0),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
 
            const SizedBox(height: 36),
            const Divider(),
            const SizedBox(height: 16),
 
            
            _infoRow(Icons.email_outlined, "frederic.dupont@gmail.com"),
            const SizedBox(height: 16),
            _infoRow(Icons.phone_outlined, "+212 607000700"),
            const SizedBox(height: 16),
            _infoRow(Icons.location_on_outlined, "Casablanca, Maroc"),
 
            const Spacer(),
 
            
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout,
                    color: Color.fromRGBO(170, 6, 133, 1.0)),
                label: const Text(
                  "Se déconnecter",
                  style: TextStyle(
                    color: Color.fromRGBO(170, 6, 133, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(
                    color: Color.fromRGBO(170, 6, 133, 1.0),
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
 
  static Widget _infoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 22, color: const Color.fromRGBO(170, 6, 133, 1.0)),
        const SizedBox(width: 14),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF444444),
          ),
        ),
      ],
    );
  }
}
 
