import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_logo_header.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VsLogoHeader(),
                const SizedBox(height: 28),
                Text(
                  'Inicio de sesion',
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                VsTextField(
                  label: 'Usuario',
                  controller: _userController,
                  validator: (v) => (v == null || v.isEmpty) ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 14),
                VsTextField(
                  label: 'Contraseña',
                  controller: _passController,
                  obscureText: true,
                  validator: (v) => (v == null || v.isEmpty) ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.go(AppRoutes.service);
                    }
                  },
                  child: const Text('Ingresar'),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary),
                    children: [
                      const TextSpan(text: 'Empieza tu viaje con nosotros,\nhaz clic aqui  '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => context.go(AppRoutes.register),
                          child: Text('Registrarse',
                              style: GoogleFonts.poppins(fontSize: 13, color: AppColors.link,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
