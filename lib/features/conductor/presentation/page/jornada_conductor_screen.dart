import 'package:flutter/material.dart';
import '../providers/conductor_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/features/profile/presentation/providers/profile_provider.dart';
import 'package:viajeseguro/features/conductor/domain/entities/conductor.dart';

class JornadaConductorScreen extends StatefulWidget {
  const JornadaConductorScreen({super.key});

  @override
  _JornadaConductorScreenState createState() => _JornadaConductorScreenState();
}

class _JornadaConductorScreenState extends State<JornadaConductorScreen> {

  final List<String> dias = [
    "Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Domingo"
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

  String buildDias() {
    return dias.map((d) => seleccion[d]!.isNotEmpty ? "1" : "0").join();
  }

  String buildHoras() {
    List<int> horasGlobal = List.filled(24, 0);

    for (var dia in seleccion.values) {
      for (var hora in dia) {
        horasGlobal[hora] = 1;
      }
    }

    return horasGlobal.join();
  }
  String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Map<String, dynamic>;
    final token = context.read<ProfileProvider>().token;
    final provider = context.watch<ConductorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Horario de conductor")),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dias.map((dia) {
              return SizedBox(
                width: 100,
                child: Column(
                  children: [
                    Text(dia, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                          height: 45,
                          color: isSelected ? Colors.green : Colors.grey[300],
                          child: Center(child: Text("$hora:00")),
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

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: () async {

            final diasStr = buildDias();
            final horasStr = buildHoras();

            final conductor = Conductor(
              idConductor: 0,
              licencia: data['licencia'],
              licenciaFechaExpedicion: formatDate(data['licenciaFechaExpedicion']),
              licenciaFechaVencimiento: formatDate(data['licenciaFechaVencimiento']),
              estatus: "habilitado",
              descripcion: data['descripcion'],
              jornada: Jornada(
                fechaRegistro: formatDate(DateTime.now()),
                fechaInicio: formatDate(DateTime.now()),
                fechaFin: formatDate(DateTime.now().add(const Duration(days: 365))),
                horario: Horario(
                  dias: diasStr,
                  horas: horasStr,
                ),
              ),
            );

            await context.read<ConductorProvider>().register(
              conductor: conductor,
              token: token!,
            );

            if (provider.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(provider.error!)),
              );
            } else {
              AppNavigation.goToHomeConductor(context);
            }
          },
          child: provider.isLoading ? const CircularProgressIndicator() : const Text("Guardar"),
        ),
      ),
    );
  }
}