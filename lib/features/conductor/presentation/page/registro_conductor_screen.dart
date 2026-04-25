import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/route_names.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import 'package:viajeseguro/features/profile/presentation/providers/profile_provider.dart';
import '../../../../core/route/app_navigation.dart';
import 'package:viajeseguro/features/profile/presentation/providers/profile_provider.dart';
import '../providers/conductor_provider.dart';

class RegistroConductorScreen extends StatefulWidget {
  const RegistroConductorScreen({super.key});

  @override
  State<RegistroConductorScreen> createState() => _RegistroConductorScreenState();
}

class _RegistroConductorScreenState extends State<RegistroConductorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _licenciaCtrl       = TextEditingController();
  final _licenciaFechaExpedicionCtrl = TextEditingController();
  final _licenciaFechaVencimientoCtrl = TextEditingController();
  final _descripcionCtrl = TextEditingController();

  @override
  void dispose() {
    _licenciaCtrl.dispose();
    _licenciaFechaExpedicionCtrl.dispose();
    _licenciaFechaVencimientoCtrl.dispose();
    _descripcionCtrl.dispose();
    super.dispose();
  }
  Future<void> _selectDate(TextEditingController controller, String label) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =
      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

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
                child: Text('Registro de conductor',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.motorcycle, color: Colors.white, size: 42),
                          const SizedBox(height: 4),
                          Text('MotoTaxi Seguro',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    VsTextField(
                      label: 'Licencia de conducir',
                      controller: _licenciaCtrl,
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _licenciaFechaExpedicionCtrl,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de expedición',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Seleccione fecha' : null,
                      onTap: () => _selectDate(_licenciaFechaExpedicionCtrl, 'Fecha de expedición'),
                    ),
                    const SizedBox(height: 14),

                    TextFormField(
                      controller: _licenciaFechaVencimientoCtrl,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Fecha de vencimiento',
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? 'Seleccione fecha' : null,
                      onTap: () => _selectDate(_licenciaFechaVencimientoCtrl, 'Fecha de vencimiento'),
                    ),


                    const SizedBox(height: 36),
                    VsTextField(
                      label: 'Descripcion de conductor',
                      controller: _descripcionCtrl,
                    ),
                    const SizedBox(height: 14),

                    ElevatedButton(
                      onPressed: () {
                        final data = {
                          "licencia": _licenciaCtrl.text,
                          "licenciaFechaExpedicion": _licenciaFechaExpedicionCtrl
                              .text,
                          "licenciaFechaVencimiento": _licenciaFechaVencimientoCtrl
                              .text,
                          "descripcion": _descripcionCtrl.text,
                        };
                        AppNavigation.pushNamed(context, RouteNames.jornadaConductor, extra: data,);
                      },
                      child: const Text('Continuar')
                    ),
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