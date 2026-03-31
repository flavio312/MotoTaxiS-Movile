import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import '../../data/models/solicitud_model.dart';

// ── Tarjeta de solicitud reutilizable ─────────────────────────────────────
class SolicitudCard extends StatelessWidget {
  final SolicitudModel solicitud;
  final VoidCallback onAceptar;
  final VoidCallback onRechazar;

  const SolicitudCard({
    super.key,
    required this.solicitud,
    required this.onAceptar,
    required this.onRechazar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre conductor + tipo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(solicitud.conductor,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
              Text(solicitud.tipoPaquete,
                  style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          // Origen / Destino labels
          Row(
            children: [
              Expanded(
                child: Text('Origen',
                    style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
              ),
              Expanded(
                child: Text('Destino',
                    textAlign: TextAlign.right,
                    style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Botones Aceptar / Rechazar
          Row(
            children: [
              _ActionBtn(
                label: 'Aceptar',
                color: Colors.green,
                onTap: onAceptar,
              ),
              const SizedBox(width: 10),
              _ActionBtn(
                label: 'Rechazar',
                color: Colors.red,
                onTap: onRechazar,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionBtn({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(label,
                style: GoogleFonts.poppins(
                    color: Colors.white, fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
