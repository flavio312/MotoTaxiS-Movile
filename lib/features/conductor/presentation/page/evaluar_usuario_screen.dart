import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';

class EvaluarUsuarioScreen extends StatefulWidget {
  const EvaluarUsuarioScreen({super.key});

  @override
  State<EvaluarUsuarioScreen> createState() => _EvaluarUsuarioScreenState();
}

class _EvaluarUsuarioScreenState extends State<EvaluarUsuarioScreen> {
  int _rating = 0;
  final _commentCtrl = TextEditingController();

  @override
  void dispose() {
    _commentCtrl.dispose();
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
                child: Text('Evalua el usuario',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Calificacion 1-5 ─────────────
                    Text('Calificacion 1-5',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),

                    // ── Estrellas ─────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        return GestureDetector(
                          onTap: () => setState(() => _rating = i + 1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              i < _rating ? Icons.star : Icons.star_border,
                              size: 38,
                              color: i < _rating
                                  ? AppColors.primary
                                  : const Color(0xFFCCCCCC),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 30),

                    // ── Comentario ────────────────────
                    TextFormField(
                      controller: _commentCtrl,
                      maxLines: 3,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        labelText: 'Comentario',
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.textSecondary),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Enviar ────────────────────────
                    ElevatedButton(
                      onPressed: () => AppNavigation.goToHistorialConductor(context),
                      child: const Text('Enviar comentario'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
