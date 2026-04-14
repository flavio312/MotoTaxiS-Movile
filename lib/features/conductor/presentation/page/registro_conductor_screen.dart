import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import '../../../../core/route/app_navigation.dart';

class RegistroConductorScreen extends StatefulWidget {
  const RegistroConductorScreen({super.key});

  @override
  State<RegistroConductorScreen> createState() => _RegistroConductorScreenState();
}

class _RegistroConductorScreenState extends State<RegistroConductorScreen> {
  final _licenciaCtrl       = TextEditingController();
  final _fechaExpedicionCtrl = TextEditingController();
  final _fechaVencimientoCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  @override
  void dispose() {
    _licenciaCtrl.dispose();
    _fechaExpedicionCtrl.dispose();
    _fechaVencimientoCtrl.dispose();
    super.dispose();
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(labelText: label),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          locale: const Locale('es', 'MX'),
        );
        if (picked != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(picked);
        }
      },
    );
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
                child: Text('Registro de conductor',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Logo box ─────────────────────
                    Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.motorcycle, color: Colors.white, size: 42),
                          const SizedBox(height: 4),
                          Text('ViajeSeguro',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Licencia ─────────────────────
                    VsTextField(
                      label: 'Licencia de conducir',
                      controller: _licenciaCtrl,
                    ),
                    const SizedBox(height: 14),

                    // ── Fechas ───────────────────────
                    Row(
                      children: [
                        Expanded(child: _buildDateField(
                          'Fecha de expedicion', _fechaExpedicionCtrl,
                        )),
                        const SizedBox(width: 10),
                        Expanded(child: _buildDateField(
                          'Fecha de vencimiento', _fechaVencimientoCtrl,
                        )),
                      ],
                    ),

                    const SizedBox(height: 36),
                    VsTextField(
                      label: 'Descripcion de conductor',
                      controller: _descripcionCtrl,
                    ),
                    const SizedBox(height: 14),

                    // ── Guardar ──────────────────────
                    ElevatedButton(
                      onPressed: () => AppNavigation.goToJornadaConductor(context),
                      child: const Text('Continuar'),
                    ),
                  ],
                ),
              ),
            ),
            const VsBottomNav(currentIndex: 1),
          ],
        ),
      ),
    );
  }
}


