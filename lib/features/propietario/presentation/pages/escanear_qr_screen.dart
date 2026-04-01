import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';

class EscanearQrScreen extends StatelessWidget {
  const EscanearQrScreen({super.key});

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
                child: Text('Asociar vehiculo',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ── Instrucción ───────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      'Apunta la cámara hacia\nel código QR',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600,
                          height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // ── Visor de cámara ───────────────
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.border, width: 2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Ícono cámara
                        const Icon(Icons.camera_alt_outlined,
                            size: 64, color: AppColors.border),

                        // Marco de escaneo (esquinas)
                        ..._buildScanCorners(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 52),

                  // ── Botón Agregar (confirmar escaneo) ─
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () =>
                          AppNavigation.gotToAsignarVehiculo(context),
                      child: const Text('Agregar'),
                    ),
                  ),
                ],
              ),
            ),
            const VsBottomNav(currentIndex: 0),
          ],
        ),
      ),
    );
  }

  // ── Esquinas decorativas del marco de escaneo ─────────────────────────
  List<Widget> _buildScanCorners() {
    const double size = 24;
    const double thickness = 3;
    const Color color = AppColors.primary;
    const double offset = 12;

    return [
      // Esquina superior izquierda
      Positioned(
        top: offset, left: offset,
        child: _Corner(size: size, thickness: thickness, color: color,
            top: true, left: true),
      ),
      // Esquina superior derecha
      Positioned(
        top: offset, right: offset,
        child: _Corner(size: size, thickness: thickness, color: color,
            top: true, left: false),
      ),
      // Esquina inferior izquierda
      Positioned(
        bottom: offset, left: offset,
        child: _Corner(size: size, thickness: thickness, color: color,
            top: false, left: true),
      ),
      // Esquina inferior derecha
      Positioned(
        bottom: offset, right: offset,
        child: _Corner(size: size, thickness: thickness, color: color,
            top: false, left: false),
      ),
    ];
  }
}

class _Corner extends StatelessWidget {
  final double size;
  final double thickness;
  final Color color;
  final bool top;
  final bool left;

  const _Corner({
    required this.size,
    required this.thickness,
    required this.color,
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerPainter(
          thickness: thickness,
          color: color,
          top: top,
          left: left,
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final double thickness;
  final Color color;
  final bool top;
  final bool left;

  const _CornerPainter({
    required this.thickness,
    required this.color,
    required this.top,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final path = Path();

    if (top && left) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (top && !left) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (!top && left) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}
