import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _tipoDireccionCtrl = TextEditingController(text: 'Casa');
  final _cpCtrl = TextEditingController();
  final _calleCtrl = TextEditingController();
  final _exteriorCtrl = TextEditingController();
  final _interiorCtrl = TextEditingController();

  String? _selectedEstado = 'Chiapas';
  String? _selectedMunicipio;
  String? _selectedAsentamiento;

  // Listas tipadas explícitamente
  final List<String> municipios = ['Tumbalá', 'Palenque', 'San Cristóbal de las Casas'];
  final Map<String, List<String>> asentamientos = {
    'Tumbalá': ['Centro', 'San Pedro'],
    'Palenque': ['San Juan', 'La Esperanza'],
    'San Cristóbal de las Casas': ['La Merced', 'Barrio El Cerrillo']
  };

  @override
  void dispose() {
    _tipoDireccionCtrl.dispose();
    _cpCtrl.dispose();
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
                'Nueva dirección',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dirección de domicilio',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    VsTextField(label: 'Tipo de dirección', controller: _tipoDireccionCtrl),
                    const SizedBox(height: 12),
                    VsTextField(
                      label: 'Código Postal',
                      controller: _cpCtrl,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),

                    // Estado fijo
                    DropdownButtonFormField<String>(
                      value: _selectedEstado,
                      items: <String>['Chiapas']
                          .map((String e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? val) => setState(() => _selectedEstado = val),
                      decoration: const InputDecoration(labelText: 'Estado'),
                    ),
                    const SizedBox(height: 12),

                    // Municipio
                    DropdownButtonFormField<String>(
                      value: _selectedMunicipio,
                      items: municipios
                          .map((String e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? val) {
                        setState(() {
                          _selectedMunicipio = val;
                          _selectedAsentamiento = null; // reset asentamiento
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Municipio'),
                    ),
                    const SizedBox(height: 12),

                    // Asentamiento dependiente del municipio
                    DropdownButtonFormField<String>(
                      value: _selectedAsentamiento,
                      items: (_selectedMunicipio != null
                          ? asentamientos[_selectedMunicipio]!
                          : <String>[])
                          .map((String e) =>
                          DropdownMenuItem<String>(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (String? val) =>
                          setState(() => _selectedAsentamiento = val),
                      decoration: const InputDecoration(labelText: 'Asentamiento'),
                    ),
                    const SizedBox(height: 12),

                    VsTextField(label: 'Calle', controller: _calleCtrl),
                    const SizedBox(height: 12),
                    Text('Número',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                            child: VsTextField(
                                label: 'Exterior', controller: _exteriorCtrl)),
                        const SizedBox(width: 10),
                        Expanded(
                            child: VsTextField(
                                label: 'Interior', controller: _interiorCtrl)),
                      ],
                    ),
                    const SizedBox(height: 28),
                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes armar tu JSON para enviar al backend
                        final direccion = {
                          "estado": _selectedEstado,
                          "municipio": _selectedMunicipio,
                          "asentamiento": _selectedAsentamiento,
                          "codigoPostal": _cpCtrl.text,
                          "calle": _calleCtrl.text,
                          "numeroExterior": _exteriorCtrl.text,
                          "numeroInterior": _interiorCtrl.text,
                          "tipoDireccion": _tipoDireccionCtrl.text,
                        };
                        print(direccion); // temporal, luego lo mandas al backend
                        AppNavigation.goToRegister(context);
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
