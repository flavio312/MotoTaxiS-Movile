import 'package:flutter/material.dart';

class HistorialDireccionesScreen extends StatefulWidget {
  const HistorialDireccionesScreen({super.key});

  @override
  State<HistorialDireccionesScreen> createState() => _HistorialDireccionesScreenState();
}

class _HistorialDireccionesScreenState extends State<HistorialDireccionesScreen> {
  @override
  final List<Map<String, String>> direcciones = [
    {"label": "Favorita", "direccion": "Palacio municipal", "fecha": "05-02-2026"},
    {"label": "Trabajo", "direccion": "Palacio municipal", "fecha": "05-02-2026"},
    {"label": "Favorita", "direccion": "Palacio municipal", "fecha": "05-02-2026"},
    {"label": "Favorita", "direccion": "Palacio municipal", "fecha": "05-02-2026"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis direcciones"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: direcciones.length,
        itemBuilder: (context, index) {
          final item = direcciones[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["label"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(item["direccion"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(item["fecha"]!,
                    style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // resaltamos el ícono de ubicación
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Direcciones"),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: "Docs"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Ajustes"),
        ],
      ),
    );
  }
}
