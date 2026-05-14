import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';

class QrConductorScreen extends StatelessWidget {
  final idConductor;
  const QrConductorScreen({super.key, required this.idConductor});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text('QR',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── QR placeholder ───────────────
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _QrPattern(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text('Escaneame',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 48),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(120, 44),
                      ),
                      onPressed: () => AppNavigation.goToHomeConductor(context, idConductor: idConductor),
                      child: Text('Salir',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── QR pattern dibujado con Canvas ────────────────────────────────────────
class _QrPattern extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(220, 220),
      painter: _QrPainter(),
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final double cell = size.width / 21;

    final pattern = [
      for (int r = 0; r < 7; r++)
        for (int c = 0; c < 7; c++)
          if (r == 0 || r == 6 || c == 0 || c == 6 || (r >= 2 && r <= 4 && c >= 2 && c <= 4))
            Offset(c.toDouble(), r.toDouble()),

      for (int r = 0; r < 7; r++)
        for (int c = 14; c < 21; c++)
          if (r == 0 || r == 6 || c == 14 || c == 20 || (r >= 2 && r <= 4 && c >= 16 && c <= 18))
            Offset(c.toDouble(), r.toDouble()),

      for (int r = 14; r < 21; r++)
        for (int c = 0; c < 7; c++)
          if (r == 14 || r == 20 || c == 0 || c == 6 || (r >= 16 && r <= 18 && c >= 2 && c <= 4))
            Offset(c.toDouble(), r.toDouble()),

      const Offset(9, 9), const Offset(10, 8), const Offset(11, 10),
      const Offset(8, 11), const Offset(12, 9), const Offset(9, 12),
      const Offset(13, 11), const Offset(10, 13), const Offset(7, 10),
      const Offset(11, 7), const Offset(8, 14), const Offset(14, 8),
      const Offset(12, 14), const Offset(13, 13), const Offset(9, 15),
    ];

    for (final p in pattern) {
      canvas.drawRect(
        Rect.fromLTWH(p.dx * cell, p.dy * cell, cell - 0.5, cell - 0.5),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
