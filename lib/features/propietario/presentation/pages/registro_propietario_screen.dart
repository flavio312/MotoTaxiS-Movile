import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class RegistroPropietarioScreen extends StatefulWidget {
  const RegistroPropietarioScreen({super.key});

  @override
  State<RegistroPropietarioScreen> createState() =>
      _RegistroPropietarioScreenState();
}

class _RegistroPropietarioScreenState
    extends State<RegistroPropietarioScreen> {
  final _rfcCtrl        = TextEditingController();
  final _razonCtrl      = TextEditingController();
  final _formKey        = GlobalKey<FormState>();

  @override
  void dispose() {
    _rfcCtrl.dispose();
    _razonCtrl.dispose();
    super.dispose();
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
                child: Text('Registro de propetario',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ── Logo box ──────────────────
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.motorcycle,
                                color: Colors.white, size: 46),
                            const SizedBox(height: 4),
                            Text('ViajeSeguro',
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 10,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── RFC ───────────────────────
                      VsTextField(
                        label: 'RFC',
                        controller: _rfcCtrl,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: 14),

                      // ── Razón Social ──────────────
                      VsTextField(
                        label: 'Razón Social',
                        controller: _razonCtrl,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: 36),

                      // ── Guardar ───────────────────
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            AppNavigation.goToHomePropietario(context);
                          }
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
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
