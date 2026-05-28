import 'package:flutter/material.dart';
 
Container itemMenu({
  required IconData icon,
  required String titre,
  VoidCallback? goto,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: const Color.fromRGBO(247, 227, 146, 1.0),
      ),
      title: Text(
        titre,
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(247, 227, 146, 1.0),
        ),
      ),
      onTap: goto,
    ),
  );
}
