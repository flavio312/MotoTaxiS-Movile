import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import '../../data/models/solicitud_model.dart';
import '../widgets/solicitud_card.dart';

class SolicitudEntranteScreen extends StatefulWidget {
  const SolicitudEntranteScreen({super.key});

  @override
  State<SolicitudEntranteScreen> createState() => _SolicitudEntranteScreenState();
}

class _SolicitudEntranteScreenState extends State<SolicitudEntranteScreen> {
  // Solicitud activa (la que llegó primero / la seleccionada)
  final SolicitudModel _solicitudActiva = SolicitudModel.mockList.first;
  final List<SolicitudModel> _otras = SolicitudModel.mockList.skip(1).toList();

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
                  Text('Solicitud entrante',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(_solicitudActiva.conductor,
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w600,
                          color: AppColors.primary)),
                ],
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Solicitud activa destacada ────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tipo de servicio
                          Text('Tipo de servicio: ${_solicitudActiva.tipoPaquete}',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          // Origen / Destino labels
                          Row(
                            children: [
                              Expanded(child: Text('Origen',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.textSecondary))),
                              Expanded(child: Text('Destino',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: AppColors.textSecondary))),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Botones Aceptar / Rechazar grandes
                          Row(
                            children: [
                              Expanded(
                                child: _BigActionBtn(
                                  label: 'Aceptar',
                                  color: Colors.green,
                                  onTap: () => AppNavigation.goToViajeConductor(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _BigActionBtn(
                                  label: 'Rechazar',
                                  color: Colors.red,
                                  onTap: () => AppNavigation.goToHomeConductor(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Otras solicitudes en cola ─────
                    ..._otras.map((s) => SolicitudCard(
                      solicitud: s,
                      onAceptar: () => AppNavigation.goToSolicitudEntrante(context),
                      onRechazar: () => setState(() => _otras.remove(s)),
                    )),
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

class _BigActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _BigActionBtn({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(label,
              style: GoogleFonts.poppins(
                  color: Colors.white, fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}
