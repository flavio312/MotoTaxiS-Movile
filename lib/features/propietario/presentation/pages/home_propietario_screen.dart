import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';
import 'package:viajeseguro/features/propietario/presentation/widgets/vehiculo_card.dart';

class HomePropietarioScreen extends StatefulWidget {
  const HomePropietarioScreen({super.key});

  @override
  State<HomePropietarioScreen> createState() => _HomePropietarioScreenState();
}

class _HomePropietarioScreenState extends State<HomePropietarioScreen> {
  List<VehiculoModel> _vehiculos = VehiculoModel.mockList;

  void _eliminarVehiculo(VehiculoModel v) {
    setState(() => _vehiculos = _vehiculos.where((e) => e != v).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 16),
              child: Center(
                child: Text('Propietario del vehiculo',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Título sección ────────────────
                    Text('Mis vehiculos',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 14),

                    // ── Lista de vehículos ────────────
                    if (_vehiculos.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Text('No tienes vehículos registrados',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: AppColors.textSecondary)),
                        ),
                      )
                    else
                      ..._vehiculos.map((v) => VehiculoCard(
                        vehiculo: v,
                        onEditar: () => AppNavigation.goToAsignarVehiculo(context),
                        onEliminar: () => _confirmarEliminar(context, v),
                      )),

                    const SizedBox(height: 24),

                    // ── Agregar vehículo ──────────────
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () =>
                          AppNavigation.goToAgregarVehiculo(context),
                      child: const Text('Agregar vehiculo'),
                    ),
                  ],
                ),
              ),
            ),
            const VsBottomNav(currentIndex: 0),
          ],
        ),
      ),
    );
  }

  // Diálogo confirmación eliminar
  Future<void> _confirmarEliminar(
      BuildContext context, VehiculoModel v) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Eliminar vehículo',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        content: Text(
            '¿Deseas eliminar el vehículo ${v.matricula}?',
            style: GoogleFonts.poppins(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true) _eliminarVehiculo(v);
  }
}
