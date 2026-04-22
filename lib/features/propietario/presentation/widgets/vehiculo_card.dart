import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';

class VehiculoCard extends StatelessWidget {
  final VehiculoModel vehiculo;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const VehiculoCard({
    super.key,
    required this.vehiculo,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Info del vehículo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vehiculo.inmatriculacion,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 2),
                Text(vehiculo.estatus,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: vehiculo.estatus == 'activo'
                            ? Colors.green
                            : AppColors.textSecondary)),
              ],
            ),
          ),

          // Acciones
          Row(
            children: [
              // Editar
              GestureDetector(
                onTap: onEditar,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.edit_outlined,
                      color: Colors.green, size: 22),
                ),
              ),
              const SizedBox(width: 4),
              // Eliminar
              GestureDetector(
                onTap: onEliminar,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.delete_outline,
                      color: Colors.red, size: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
