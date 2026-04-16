import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import '../providers/propietario_provider.dart';
import 'package:viajeseguro/features/profile/presentation/providers/profile_provider.dart';

class RegistroPropietarioScreen extends StatefulWidget {
  const RegistroPropietarioScreen({super.key});

  @override
  State<RegistroPropietarioScreen> createState() =>
      _RegistroPropietarioScreenState();
}

class _RegistroPropietarioScreenState extends State<RegistroPropietarioScreen> {
  final _rfcCtrl        = TextEditingController();
  final _razonCtrl      = TextEditingController();
  final _formKey        = GlobalKey<FormState>();

  @override
  void dispose() {
    _rfcCtrl.dispose();
    _razonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final propietarioProvider =context.watch<PropietarioProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text('Registro de propetario',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32, vertical: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.motorcycle,
                                color: Colors.white, size: 46),
                            const SizedBox(height: 4),
                            Text('ViajeSeguro',
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 10,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      VsTextField(
                        label: 'RFC',
                        controller: _rfcCtrl,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: 14),
                      VsTextField(
                        label: 'Razón Social',
                        controller: _razonCtrl,
                        validator: (v) =>
                        (v == null || v.isEmpty) ? 'Campo requerido' : null,
                      ),
                      const SizedBox(height: 36),
                      ElevatedButton(
                        onPressed: propietarioProvider.isLoading ? null : () async {
                          if (!(_formKey.currentState?.validate() ?? false)) return;

                          final profileProvider = context.read<ProfileProvider>();
                          final token = profileProvider.token;

                          if (token == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Token no disponible')),
                            );
                            return;
                          }

                          final data = {
                            "rfc": _rfcCtrl.text,
                            "razonSocial": _razonCtrl.text,
                          };

                          await context.read<PropietarioProvider>().register(
                            data: data,
                            token: token,
                          );

                          if (!context.mounted) return;

                          final error = context.read<PropietarioProvider>().error;

                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error)),
                            );
                            return;
                          }

                          // ✅ Mostrar diálogo de solicitud procesada
                          await showDialog(
                            context: context,
                            barrierDismissible: false, // El usuario debe presionar el botón
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              icon: const Icon(
                                Icons.hourglass_top_rounded,
                                color: AppColors.primary,
                                size: 48,
                              ),
                              title: Text(
                                '¡Solicitud enviada!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              content: Text(
                                'Su solicitud está siendo procesada por el administrador.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Cierra el diálogo
                                    AppNavigation.goToHomePropietario(context);
                                  },
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            ),
                          );
                        }, child: null,
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
