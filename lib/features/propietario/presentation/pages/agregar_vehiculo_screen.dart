import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';
import '../providers/vehiculo_provider.dart';

class AgregarVehiculoScreen extends StatefulWidget {
  const AgregarVehiculoScreen({super.key});

  @override
  State<AgregarVehiculoScreen> createState() => _AgregarVehiculoScreenState();
}

class _AgregarVehiculoScreenState extends State<AgregarVehiculoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inmatriculacionCtrl = TextEditingController();
  final _modeloCtrl = TextEditingController();
  final _colorCtrl = TextEditingController();
  final _fechaAdquisionCtrl = TextEditingController();
  final _estatusCtrl = TextEditingController();
  Color _currentColor = Colors.blue;

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Selecciona un color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (color) {
                setState(() {
                  _currentColor = color;
                  _colorCtrl.text = color.value.toRadixString(16);
                });
              },
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Aceptar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
  String _colorToHex(Color color) {
    // Convierte Color a #RRGGBB
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }


  @override
  void dispose() {
    _inmatriculacionCtrl.dispose();
    _modeloCtrl.dispose();
    _colorCtrl.dispose();
    _fechaAdquisionCtrl.dispose();
    _estatusCtrl.dispose();
    super.dispose();
  }

  int _mapModeloToId(String modelo) {
    switch (modelo.toLowerCase()) {
      case 'Italika FT150':
        return 1;
      case 'Italika FT200':
        return 2;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehiculoProvider = context.watch<VehiculoProvider>();
    final token = context.read<AuthProvider>().token;

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
                      DropdownButtonFormField<String>(
                        value: null,
                        decoration:
                        const InputDecoration(labelText: 'Modelo'),
                        items: const [
                          DropdownMenuItem(
                              value: 'Italika FT150',
                              child: Text('Italika FT150')),
                          DropdownMenuItem(
                              value: 'Italika FT200',
                              child: Text('Italika FT200')),
                          DropdownMenuItem(
                              value: 'otro', child: Text('Otro')),
                        ],
                        onChanged: (value) {
                          _modeloCtrl.text = value ?? '';
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Seleccione modelo del auto'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      _FieldLabel('Color'),
                      TextField(
                        controller: _colorCtrl,
                        readOnly: true,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.color_lens),
                              onPressed: _openColorPicker,
                            ),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 50,
                        height: 50,
                        color: _currentColor,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _fechaAdquisionCtrl,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Fecha de Adquisición',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            _fechaAdquisionCtrl.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                          }
                        },
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Seleccione fecha'
                            : null,
                      ),
                      const SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: vehiculoProvider.isLoading
                            ? null
                            : () async {
                          if (!(_formKey.currentState?.validate() ??
                              false)) return;

                          final requestData = {
                            "inmatriculacion":
                            _inmatriculacionCtrl.text,
                            "idModelo":
                            _mapModeloToId(_modeloCtrl.text),
                            "color": _colorToHex(_currentColor),
                            "fechaAdquisicion":
                            _fechaAdquisionCtrl.text,
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
                                  content: Text(
                                      vehiculoProvider.error!)),
                            );
                          } else {
                            AppNavigation.goToAsignarVehiculo(
                                context);
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
