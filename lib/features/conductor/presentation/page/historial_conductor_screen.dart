import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';

class _HistorialItem {
  final String fecha;
  final String estado;
  final String pasajero;
  final String direccion;
  final String subDireccion;
  final String tipoServicio;

  const _HistorialItem({
    required this.fecha,
    required this.estado,
    required this.pasajero,
    required this.direccion,
    required this.subDireccion,
    required this.tipoServicio,
  });
}

class HistorialConductorScreen extends StatelessWidget {
  const HistorialConductorScreen({super.key});

  static const List<_HistorialItem> _items = [
    _HistorialItem(
      fecha: '27/01/2026, 9:41 pm',
      estado: 'Terminado',
      pasajero: 'DL Flavio',
      direccion: 'Calle primera centro 225',
      subDireccion: 'Calle 12a ote. Sur',
      tipoServicio: 'Paqueteria',
    ),
    _HistorialItem(
      fecha: '27/01/2026, 9:41 pm',
      estado: 'Terminado',
      pasajero: 'DL Flavio',
      direccion: 'Calle primera centro 225',
      subDireccion: 'Calle 12a ote. Sur',
      tipoServicio: 'Paqueteria',
    ),
    _HistorialItem(
      fecha: '27/01/2026, 9:41 pm',
      estado: 'Terminado',
      pasajero: 'DL Flavio',
      direccion: 'Calle primera centro 225',
      subDireccion: 'Calle 12a ote. Sur',
      tipoServicio: 'Transporte',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Center(
                child: Text('Historial de viajes aceptados',
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            // ── Lista ────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _HistorialCard(item: item);
                },
              ),
            ),
            const VsBottomNav(currentIndex: 2),
          ],
        ),
      ),
    );
  }
}

class _HistorialCard extends StatelessWidget {
  final _HistorialItem item;
  const _HistorialCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fecha + estado
          Row(
            children: [
              Text('${item.fecha}  ',
                  style: GoogleFonts.poppins(
                      fontSize: 11, color: AppColors.textSecondary)),
              Text(item.estado,
                  style: GoogleFonts.poppins(
                      fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 4),

          // Pasajero
          Text('Pasajero: ${item.pasajero}',
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),

          // Dirección
          Text(item.direccion,
              style: GoogleFonts.poppins(fontSize: 12)),
          const SizedBox(height: 2),

          // Sub-dirección naranja
          Text(item.subDireccion,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.primary)),
          const SizedBox(height: 4),

          // Tipo de servicio
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Tipo de servicio: ${item.tipoServicio}',
                style: GoogleFonts.poppins(
                    fontSize: 11, color: AppColors.primary,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
