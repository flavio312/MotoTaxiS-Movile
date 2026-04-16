import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import '../../data/models/solicitud_model.dart';
import '../widgets/solicitud_card.dart';

class HomeConductorScreen extends StatefulWidget {
  const HomeConductorScreen({super.key});

  @override
  State<HomeConductorScreen> createState() => _HomeConductorScreenState();
}

class _HomeConductorScreenState extends State<HomeConductorScreen> {
  // Estado del conductor
  bool _habilitado = true;

  // Lista de solicitudes (mock — conectar a socket en implementación real)
  final List<SolicitudModel> _solicitudes = SolicitudModel.mockList;

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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Estatus ──────────────────────
                    Text('Estatus',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _EstadoChip(
                          label: 'Habilitado',
                          isSelected: _habilitado,
                          onTap: () => setState(() => _habilitado = true),
                        ),
                        const SizedBox(width: 10),
                        _EstadoChip(
                          label: 'Deshabilitado',
                          isSelected: !_habilitado,
                          onTap: () => setState(() => _habilitado = false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Compartir info ────────────────
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => AppNavigation.goToQrConductor(context),
                        child: Text('Compartir informacion',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Lista de solicitudes ──────────
                    ..._solicitudes.map((s) => SolicitudCard(
                      solicitud: s,
                      onAceptar: () => AppNavigation.goToSolicitudEntrante(context),
                      onRechazar: () {
                        setState(() => _solicitudes.remove(s));
                      },
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

// ── Chip de estado Habilitado / Deshabilitado ─────────────────────────────
class _EstadoChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _EstadoChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDDDDDD) : Colors.transparent,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: GoogleFonts.poppins(
                fontSize: 13, fontWeight: FontWeight.w500,
                color: AppColors.textPrimary)),
      ),
    );
  }
}
