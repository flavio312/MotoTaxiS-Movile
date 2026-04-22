import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/features/propietario/presentation/widgets/vehiculo_card.dart';
import '../providers/vehiculo_provider.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';
import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';

class HomePropietarioScreen extends StatefulWidget {
  const HomePropietarioScreen({super.key});

  @override
  State<HomePropietarioScreen> createState() => _HomePropietarioScreenState();
}

class _HomePropietarioScreenState extends State<HomePropietarioScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final token = context.read<AuthProvider>().token;
      context.read<VehiculoProvider>().loadVehiculos(token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VehiculoProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mis vehiculos',
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 14),

                    if (provider.vehiculos.isEmpty)
                      Center(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 32),
                          child: Text(
                            'No tienes vehículos registrados',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    else
                      ...provider.vehiculos.map((v) => VehiculoCard(
                        vehiculo: v,
                        onEditar: () =>
                            AppNavigation.goToAsignarVehiculo(context),
                        onEliminar: () =>
                            _confirmarEliminar(context, v),
                      )),

                    const SizedBox(height: 24),

                    ElevatedButton(
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

  Future<void> _confirmarEliminar(
      BuildContext context, VehiculoModel v) async {

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar vehículo'),
        content: Text('¿Deseas eliminar ${v.inmatriculacion}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      print("Eliminar vehiculo ${v.idVehiculo}");
    }
  }
}