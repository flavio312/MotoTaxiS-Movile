import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import '../../../../core/route/app_navigation.dart';

class ViajeConductorScreen extends StatelessWidget {
  const ViajeConductorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ─────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Conductor',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('Nombre',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // ── Mapa ─────────────────────────
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: const Color(0xFFB0BEC5),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: const SizedBox.expand(
                              child: Center(
                                child: Icon(Icons.map, size: 70,
                                    color: Color(0xFF78909C)),
                              ),
                            ),
                          ),
                          // Marker A
                          Positioned(
                            left: 50, bottom: 55,
                            child: _MapPin(label: 'A', color: Colors.red),
                          ),
                          // Marker B
                          Positioned(
                            right: 50, top: 40,
                            child: _MapPin(label: 'B', color: Colors.red),
                          ),
                          // Punto naranja (conductor)
                          Positioned(
                            left: 110, bottom: 80,
                            child: Container(
                              width: 12, height: 12,
                              decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Tarjeta info viaje ────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('En curso',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, fontWeight: FontWeight.w600,
                                    color: AppColors.primary)),
                          ),
                          const SizedBox(height: 6),
                          Text('Pasajero: DL Flavio',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('Tipo de servicio: Transporte',
                              style: GoogleFonts.poppins(fontSize: 13)),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Calle 12a ote. Sur',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Terminar el servicio ──────────
                    _ServiceBtn(
                      label: 'TERMINAR EL SERVIVIO',
                      icon: Icons.lock_outline,
                      color: const Color(0xFF2C2C2C),
                      textColor: Colors.white,
                      onTap: () => AppNavigation.gotToEvaluarUsuario(context),
                    ),
                    const SizedBox(height: 10),

                    // ── Suspender ────────────────────
                    _ServiceBtn(
                      label: 'Suspender servicio',
                      color: AppColors.primary,
                      textColor: Colors.white,
                      onTap: () => AppNavigation.gotToHomeConductor(context),
                    ),
                    const SizedBox(height: 10),

                    // ── Reportar ─────────────────────
                    _ServiceBtn(
                      label: 'Reportar incidente',
                      color: const Color(0xFFD32F2F),
                      textColor: Colors.white,
                      onTap: () {},
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

// ── Botón de acción del viaje ─────────────────────────────────────────────
class _ServiceBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ServiceBtn({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 18),
              const SizedBox(width: 8),
            ],
            Text(label,
                style: GoogleFonts.poppins(
                    color: textColor, fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

// ── Pin de mapa ───────────────────────────────────────────────────────────
class _MapPin extends StatelessWidget {
  final String label;
  final Color color;
  const _MapPin({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Text(label,
              style: const TextStyle(color: Colors.white,
                  fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        Container(width: 2, height: 8, color: color),
      ],
    );
  }
}
