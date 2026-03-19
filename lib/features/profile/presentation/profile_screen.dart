import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _selectedRol = 'Pasajero';

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Registro de usuario',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 28),
              // Profile photo
              Text('Foto de perfil',
                  style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFBBBBBB),
                ),
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 28),
              VsTextField(label: 'Nombre de usuario', controller: _usernameCtrl),
              const SizedBox(height: 14),
              VsTextField(label: 'Contraseña', controller: _passCtrl, obscureText: true),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Rol',
                    style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 8),
              ...[
                _RolOption(label: 'Pasajero', value: 'Pasajero',
                    groupValue: _selectedRol, onChanged: (v) => setState(() => _selectedRol = v!)),
                _RolOption(label: 'Conductor', value: 'Conductor',
                    groupValue: _selectedRol, onChanged: (v) => setState(() => _selectedRol = v!)),
                _RolOption(label: 'Propietario', value: 'Propietario',
                    groupValue: _selectedRol, onChanged: (v) => setState(() => _selectedRol = v!)),
              ],
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.service),
                child: const Text('Registrarse'),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => context.go(AppRoutes.register),
                child: Text('Regresar',
                    style: GoogleFonts.poppins(fontSize: 14, color: AppColors.link,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RolOption extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _RolOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
      ],
    );
  }
}
