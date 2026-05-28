import 'package:flutter/material.dart';
 
DrawerHeader header() {
  
  return DrawerHeader(
    decoration: const BoxDecoration(
      color: Color.fromRGBO(234, 108, 238, 1.0),
    ),
    padding: const EdgeInsets.all(16),
    child: SizedBox.expand(
      child: Stack(
        children: [
          const Align(
            alignment: Alignment(-1.0, 0.0),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Text(
                "FD",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(1.0, -0.2),
            child: Text(
              "Frédéric Dupont",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Align(
            alignment: Alignment(1.0, 0.4),
            child: Text(
              "Utilisateur Standard",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ),
        ],
      ),
    ),
  );
}
