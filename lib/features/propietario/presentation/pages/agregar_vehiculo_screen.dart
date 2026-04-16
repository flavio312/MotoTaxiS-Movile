import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  const AgregarVehiculoScreen({super.key});

  @override
  State<AgregarVehiculoScreen> createState() => _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  final _formKey            = GlobalKey<FormState>();
  final _matriculaCtrl      = TextEditingController();
  final _modeloCtrl         = TextEditingController();
  final _colorCtrl          = TextEditingController();
  final _estatusCtrl        = TextEditingController();
  final _fechaAdqCtrl       = TextEditingController();

  @override
  void dispose() {
    _matriculaCtrl.dispose();
    _modeloCtrl.dispose();
    _colorCtrl.dispose();
    _estatusCtrl.dispose();
    _fechaAdqCtrl.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (fecha != null) {
      _fechaAdqCtrl.text =
      '${fecha.day.toString().padLeft(2, '0')}/'
          '${fecha.month.toString().padLeft(2, '0')}/'
          '${fecha.year}';
    }
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
                child: Text('Agregar nuevo  vehiculo',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 28, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Matrícula ─────────────────────
                      _FieldLabel('Matriula'),
                      VsTextField(
                        label: '',
                        controller: _matriculaCtrl,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),

                      // ── Modelo ────────────────────────
                      _FieldLabel('Modelo'),
                      VsTextField(
                        label: '',
                        controller: _modeloCtrl,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),

                      // ── Color ─────────────────────────
                      _FieldLabel('Color'),
                      VsTextField(
                        label: '',
                        controller: _colorCtrl,
                      ),
                      const SizedBox(height: 16),

                      // ── Estatus ───────────────────────
                      _FieldLabel('Estatus'),
                      VsTextField(
                        label: '',
                        controller: _estatusCtrl,
                      ),
                      const SizedBox(height: 16),

                      // ── Fecha de adquisición ──────────
                      _FieldLabel('Fecha de adquisicion'),
                      GestureDetector(
                        onTap: _seleccionarFecha,
                        child: AbsorbPointer(
                          child: VsTextField(
                            label: '',
                            controller: _fechaAdqCtrl,
                            keyboardType: TextInputType.datetime,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // ── Agregar ───────────────────────
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(180, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              AppNavigation.goToAsignarVehiculo(context);
                            }
                          },
                          child: const Text('Agregar'),
                        ),
                      ),
                    ],
                  ),
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

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text,
          style: GoogleFonts.poppins(
              fontSize: 12, color: AppColors.textSecondary)),
    );
  }
}
