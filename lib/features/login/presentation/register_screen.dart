import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_logo_header.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombresCtrl = TextEditingController();
  final _apellidoPCtrl = TextEditingController();
  final _apellidoMCtrl = TextEditingController();
  final _sexoCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();

  @override
  void dispose() {
    _nombresCtrl.dispose();
    _apellidoPCtrl.dispose();
    _apellidoMCtrl.dispose();
    _sexoCtrl.dispose();
    _telefonoCtrl.dispose();
    _correoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VsLogoHeader(),
                const SizedBox(height: 24),
                VsTextField(label: 'Nombres', controller: _nombresCtrl),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: VsTextField(label: 'Apellido Paterno', controller: _apellidoPCtrl)),
                    const SizedBox(width: 10),
                    Expanded(child: VsTextField(label: 'Apellido Materno', controller: _apellidoMCtrl)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: VsTextField(label: 'Sexo', controller: _sexoCtrl)),
                    const SizedBox(width: 10),
                    Expanded(child: VsTextField(label: 'Telefono',
                        controller: _telefonoCtrl,
                        keyboardType: TextInputType.phone)),
                  ],
                ),
                const SizedBox(height: 12),
                VsTextField(label: 'Correo electronico', controller: _correoCtrl,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.go(AppRoutes.address);
                    }
                  },
                  child: const Text('Continuar'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ya tengo mi cuenta  ',
                        style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: Text('Iniciar sesion',
                          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.link,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
