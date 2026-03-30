import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String _tipoServicio = 'Pasajero';
  final _origenCtrl = TextEditingController();
  final _destinoCtrl = TextEditingController();
  final _paqueteCtrl = TextEditingController();
  final _viajeCtrl = TextEditingController();

  @override
  void dispose() {
    _origenCtrl.dispose();
    _destinoCtrl.dispose();
    _paqueteCtrl.dispose();
    _viajeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Logo bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ViajeSeguro',
                      style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map placeholder
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFE0E0E0),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: const Color(0xFFCFD8DC),
                              child: const Center(
                                child: Icon(Icons.map, size: 60, color: Color(0xFF90A4AE)),
                              ),
                            ),
                          ),
                          // Point A
                          Positioned(
                            left: 40, top: 60,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                              child: const Text('A',
                                  style: TextStyle(color: Colors.white, fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          // Point B
                          Positioned(
                            right: 40, top: 40,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: const Text('B',
                                  style: TextStyle(color: Colors.white, fontSize: 10,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Tipo de servicio',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _ServiceRadio(label: 'Pasajero', value: 'Pasajero',
                            groupValue: _tipoServicio,
                            onChanged: (v) => setState(() => _tipoServicio = v!)),
                        const SizedBox(width: 16),
                        _ServiceRadio(label: 'Paqueteria', value: 'Paqueteria',
                            groupValue: _tipoServicio,
                            onChanged: (v) => setState(() => _tipoServicio = v!)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Direccion de origen',
                                  style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                              const SizedBox(height: 4),
                              VsTextField(label: '', controller: _origenCtrl),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Direccion de destino',
                                  style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textSecondary)),
                              const SizedBox(height: 4),
                              VsTextField(label: '', controller: _destinoCtrl),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Detalles del paquete',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    VsTextField(label: '', controller: _paqueteCtrl),
                    const SizedBox(height: 12),
                    Text('Detalles del viaje',
                        style: GoogleFonts.poppins(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    VsTextField(label: '', controller: _viajeCtrl),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Solicitar servicio'),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.cancelButton,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () => AppNavigation.goToLogin(context),
                        child: Text('Cancelar servicio',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w600,
                                color: const Color(0xFF5A4A00))),
                      ),
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

class _ServiceRadio extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _ServiceRadio({
    required this.label, required this.value,
    required this.groupValue, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value, groupValue: groupValue,
          onChanged: onChanged, activeColor: AppColors.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text(label, style: GoogleFonts.poppins(fontSize: 13)),
      ],
    );
  }
}
