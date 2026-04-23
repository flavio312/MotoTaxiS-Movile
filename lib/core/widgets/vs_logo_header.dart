import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';

class VsLogoHeader extends StatelessWidget {
  const VsLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'MotoTaxi Seguro',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Container(height: 3, color: AppColors.primary),
        const SizedBox(height: 20),
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Image.asset(
              'assets/jaguar.png',
              width: 200,
              height: 130,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
