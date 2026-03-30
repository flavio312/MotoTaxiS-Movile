import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _tipoDireccionCtrl = TextEditingController(text: 'Casa');
  final _cpCtrl = TextEditingController();
  final _estadoCtrl = TextEditingController();
  final _municipioCtrl = TextEditingController();
  final _asentamientoCtrl = TextEditingController();
  final _calleCtrl = TextEditingController();
  final _exteriorCtrl = TextEditingController();
  final _interiorCtrl = TextEditingController();

  @override
  void dispose() {
    _tipoDireccionCtrl.dispose();
    _cpCtrl.dispose();
    _estadoCtrl.dispose();
    _municipioCtrl.dispose();
    _asentamientoCtrl.dispose();
    _calleCtrl.dispose();
    _exteriorCtrl.dispose();
    _interiorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Nueva direccion',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Direccion de domicilio',
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    VsTextField(label: 'Tipo de direccion', controller: _tipoDireccionCtrl),
                    const SizedBox(height: 12),
                    VsTextField(label: 'Codigo Postal', controller: _cpCtrl,
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 12),
                    VsTextField(label: 'Estado', controller: _estadoCtrl),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: VsTextField(label: 'Municipio', controller: _municipioCtrl)),
                        const SizedBox(width: 10),
                        Expanded(child: VsTextField(label: 'Asentamiento', controller: _asentamientoCtrl)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    VsTextField(label: 'Calle', controller: _calleCtrl),
                    const SizedBox(height: 12),
                    Text('Numero',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(child: VsTextField(label: 'Exterior', controller: _exteriorCtrl)),
                        const SizedBox(width: 10),
                        Expanded(child: VsTextField(label: 'Interior', controller: _interiorCtrl)),
                      ],
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () => AppNavigation.goToRegister(context),
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ),
            const VsBottomNav(currentIndex: 3),
          ],
        ),
      ),
    );
  }
}
