import 'package:flutter/material.dart';

Widget itemMenu({
  required IconData icon,
  required String titre,
  required VoidCallback goto,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: goto,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF14B8A6), size: 22), // turquoise
              const SizedBox(width: 16),
              Text(
                titre,
                style: const TextStyle(
                  color: Color(0xFF1E293B), // gris ardoise foncé
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}