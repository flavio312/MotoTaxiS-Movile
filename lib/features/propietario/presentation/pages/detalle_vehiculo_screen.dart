import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import 'package:viajeseguro/features/propietario/data/models/vehiculo_model.dart';

class DetalleVehiculoScreen extends StatefulWidget {
  final VehiculoModel? vehiculo; // null = modo vista, not-null = modo edición
  const DetalleVehiculoScreen({super.key, this.vehiculo});

  @override
  State<DetalleVehiculoScreen> createState() => _DetalleVehiculoScreenState();
}

class _DetalleVehiculoScreenState extends State<DetalleVehiculoScreen> {
  late final TextEditingController _matriculaCtrl;
  late final TextEditingController _modeloCtrl;
  late final TextEditingController _estatusCtrl;

  // Color seleccionado (el diseño muestra un bloque rojo)
  Color _colorSeleccionado = Colors.red;

  @override
  void initState() {
    super.initState();
    _matriculaCtrl = TextEditingController(
        text: widget.vehiculo?.matricula ?? '');
    _modeloCtrl    = TextEditingController(
        text: widget.vehiculo?.modelo ?? '');
    _estatusCtrl   = TextEditingController(
        text: widget.vehiculo?.estatus ?? '');
  }

  @override
  void dispose() {
    _matriculaCtrl.dispose();
    _modeloCtrl.dispose();
    _estatusCtrl.dispose();
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
                child: Text('Detalle del vehiculo',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Matrícula ─────────────────────
                    Text('Matriula',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    VsTextField(
                      label: '',
                      controller: _matriculaCtrl,
                    ),
                    const SizedBox(height: 16),

                    // ── Modelo ────────────────────────
                    Text('Modelo',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    VsTextField(
                      label: '',
                      controller: _modeloCtrl,
                    ),
                    const SizedBox(height: 16),

                    // ── Color ─────────────────────────
                    Text('Color',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 8),
                    _ColorSelector(
                      colorActual: _colorSeleccionado,
                      onColorChanged: (c) =>
                          setState(() => _colorSeleccionado = c),
                    ),
                    const SizedBox(height: 16),

                    // ── Estatus ───────────────────────
                    Text('Estatus',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    VsTextField(
                      label: '',
                      controller: _estatusCtrl,
                    ),
                    const SizedBox(height: 36),

                    // ── Regresar ──────────────────────
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(180, 48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () =>
                            AppNavigation.gotToHomePropietario(context),
                        child: const Text('Regresar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VsBottomNav(currentIndex: 0),
          ],
        ),
      ),
    );
  }
}

// ── Selector de color con swatches ────────────────────────────────────────
class _ColorSelector extends StatelessWidget {
  final Color colorActual;
  final ValueChanged<Color> onColorChanged;

  static const List<Color> _colores = [
    Colors.red,
    Colors.blue,
    Colors.black,
    Colors.white,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
  ];

  const _ColorSelector({
    required this.colorActual,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bloque de color actual (como en el diseño)
        GestureDetector(
          onTap: () => _mostrarSwatches(context),
          child: Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: colorActual,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }

  void _mostrarSwatches(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selecciona un color',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _colores.map((c) => GestureDetector(
                onTap: () {
                  onColorChanged(c);
                  Navigator.pop(ctx);
                },
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: c == colorActual
                          ? AppColors.primary
                          : AppColors.border,
                      width: c == colorActual ? 3 : 1,
                    ),
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
