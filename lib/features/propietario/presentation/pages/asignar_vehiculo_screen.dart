import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class AsignarVehiculoScreen extends StatefulWidget {
  const AsignarVehiculoScreen({super.key});

  @override
  State<AsignarVehiculoScreen> createState() => _AsignarVehiculoScreenState();
}

class _AsignarVehiculoScreenState extends State<AsignarVehiculoScreen> {
  final _conductorCtrl    = TextEditingController();
  final _fechaInicioCtrl  = TextEditingController();
  final _fechaFinCtrl     = TextEditingController();
  final _matriculaCtrl    = TextEditingController();

  @override
  void dispose() {
    _conductorCtrl.dispose();
    _fechaInicioCtrl.dispose();
    _fechaFinCtrl.dispose();
    _matriculaCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha(TextEditingController ctrl) async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (fecha != null) {
      ctrl.text =
      '${fecha.day.toString().padLeft(2, '0')}/'
          '${fecha.month.toString().padLeft(2, '0')}/'
          '${fecha.year}';
    }
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text('Asignar vehiculo',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Conductor + Escanear QR ───────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Conductor',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              VsTextField(
                                label: '',
                                controller: _conductorCtrl,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Botón escanear QR
                        GestureDetector(
                          onTap: () => AppNavigation.goToEscanearQr(context),
                          child: Column(
                            children: [
                              Text('Escanear',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.camera_alt_outlined,
                                    size: 28, color: AppColors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // ── Fecha de inicio ───────────────
                    Text('Fecha de inicio',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => _seleccionarFecha(_fechaInicioCtrl),
                      child: AbsorbPointer(
                        child: VsTextField(
                          label: '',
                          controller: _fechaInicioCtrl,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Fecha de fin ──────────────────
                    Text('Fecha de fin',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => _seleccionarFecha(_fechaFinCtrl),
                      child: AbsorbPointer(
                        child: VsTextField(
                          label: '',
                          controller: _fechaFinCtrl,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Matrícula ─────────────────────
                    Text('Matricula',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    VsTextField(
                      label: '',
                      controller: _matriculaCtrl,
                    ),
                    const SizedBox(height: 36),

                    // ── Asignar ───────────────────────
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(180, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () =>
                            AppNavigation.goToHomePropietario(context),
                        child: const Text('Asignar'),
                      ),
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
}
