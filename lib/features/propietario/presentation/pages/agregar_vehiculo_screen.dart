import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import 'package:viajeseguro/features/profile/presentation/providers/profile_provider.dart';
import '../providers/vehiculo_provider.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  const AgregarVehiculoScreen({super.key});

  @override
  State<AgregarVehiculoScreen> createState() => _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _inmatriculacionCtrl = TextEditingController();
  final _idModeloCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _fechaAdquisionCtrl = TextEditingController();
  final _estatusCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  @override
  void dispose() {
    _inmatriculacionCtrl.dispose();
    _idModeloCtrl.dispose();
    _colorCtrl.dispose();
    _fechaAdquisionCtrl.dispose();
    _estatusCtrl.dispose();
    _descripcionCtrl.dispose();

    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (fecha != null) {
      _fechaAdquisionCtrl.text =
      "${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoProvider = context.watch<VehiculoProvider>();
    final token = context.read<ProfileProvider>().token;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Agregar nuevo vehículo',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _FieldLabel('Matrícula'),
                      VsTextField(
                        label: '',
                        controller: _inmatriculacionCtrl,
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),

                      _FieldLabel('Modelo'),
                      VsTextField(
                        label: '',
                        controller: _idModeloCtrl,
                        validator: (v) =>
                        v == null || v.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 16),

                      _FieldLabel('Color'),
                      VsTextField(
                        label: '',
                        controller: _colorCtrl,
                      ),
                      const SizedBox(height: 16),

                      _FieldLabel('Estatus'),
                      VsTextField(
                        label: '',
                        controller: _estatusCtrl,
                      ),
                      const SizedBox(height: 16),

                      _FieldLabel('Fecha de adquisición'),
                      GestureDetector(
                        onTap: _seleccionarFecha,
                        child: AbsorbPointer(
                          child: VsTextField(
                            label: '',
                            controller: _fechaAdquisionCtrl,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      ElevatedButton(
                        onPressed: vehiculoProvider.isLoading
                            ? null
                            : () async {
                          if (!(_formKey.currentState?.validate() ??
                              false)) return;

                          final requestData = {
                            "matricula": _inmatriculacionCtrl.text,
                            "modelo": _idModeloCtrl.text,
                            "color": _colorCtrl.text,
                            "estatus": _estatusCtrl.text,
                            "fechaAdquisicion": _fechaAdquisionCtrl.text,
                          };

                          await context
                              .read<VehiculoProvider>()
                              .register(
                            data: requestData,
                            token: token!,
                          );

                          if (vehiculoProvider.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                  Text(vehiculoProvider.error!)),
                            );
                          } else {
                            AppNavigation.goToAsignarVehiculo(context);
                          }
                        },
                        child: vehiculoProvider.isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Agregar'),
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
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}