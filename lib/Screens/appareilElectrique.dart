import 'package:flutter/material.dart';
import 'package:projet_final/Components/MyDrawer.dart';
 
class AppareilElectrique extends StatelessWidget {
  const AppareilElectrique({super.key});
 
  final List<Map<String, String>> appareils = const [
    {
      "name": "TV",
      "image": "https://cdn-icons-png.flaticon.com/512/1048/1048941.png",
      "power": "150W"
    },
    {
      "name": "Réfrigérateur",
      "image": "https://cdn-icons-png.flaticon.com/512/3659/3659898.png",
      "power": "400W"
    },
    {
      "name": "Climatiseur",
      "image": "https://cdn-icons-png.flaticon.com/512/2933/2933925.png",
      "power": "1200W"
    },
    {
      "name": "Machine à laver",
      "image": "https://cdn-icons-png.flaticon.com/512/2933/2933820.png",
      "power": "900W"
    },
    {
      "name": "Lampe LED",
      "image": "https://cdn-icons-png.flaticon.com/512/427/427735.png",
      "power": "12W"
    },
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appareils Électriques",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(170, 6, 133, 1.0),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: MyDrawer(context),
      body: Container(
        color: const Color(0xFFF5F0FA),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: appareils.length,
          itemBuilder: (context, index) {
            final appareil = appareils[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                leading: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      appareil["image"]!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.electrical_services,
                              size: 30,
                              color: Color.fromRGBO(170, 6, 133, 1.0)),
                    ),
                  ),
                ),
                title: Text(
                  appareil["name"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                subtitle: const Text(
                  "Consommation estimée",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(234, 108, 238, 1.0),
                        Color.fromRGBO(170, 6, 133, 1.0),
                      ],
                    ),
                  ),
                  child: Text(
                    appareil["power"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
