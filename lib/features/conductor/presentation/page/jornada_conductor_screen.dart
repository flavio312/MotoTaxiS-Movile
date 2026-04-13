import 'package:flutter/material.dart';

class JornadaConductorScreen extends StatefulWidget {
  const JornadaConductorScreen({super.key});

  @override
  _JornadaConductorScreenState createState() => _JornadaConductorScreenState();
}

class _JornadaConductorScreenState extends State<JornadaConductorScreen> {
  final List<String> dias = [
    "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"
  ];

  final List<int> horas = List.generate(24, (index) => index);
  Map<String, Set<int>> seleccion = {};

  @override
  void initState() {
    super.initState();
    for (var dia in dias) {
      seleccion[dia] = {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Horario de conductor") ,backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        // Scroll Vertical para ver todas las horas (0 a 23)
        child: SingleChildScrollView(
          // Scroll Horizontal para ver todos los días
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dias.map((dia) {
                return SizedBox(
                  width: 100, // Ancho fijo por columna para que el scroll funcione
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(dia, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      // Generamos los botones de horas
                      ...horas.map((hora) {
                        final isSelected = seleccion[dia]!.contains(hora);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                seleccion[dia]!.remove(hora);
                              } else {
                                seleccion[dia]!.add(hora);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(8),
                            height: 45, // Altura fija para mantener simetría
                            decoration: BoxDecoration(
                              // Mantenemos tus colores originales
                              color: isSelected ? Colors.green : Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Text(
                                "$hora:00",
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          onPressed: () {
            print(seleccion);
          },
          child: const Text("Guardar"),
        ),
      ),
    );
  }
}