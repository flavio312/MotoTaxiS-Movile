import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nombreUsuarioCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String _selectedRol = 'Pasajero';

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nombreUsuarioCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final provider = context.read<ProfileProvider>();
    final XFile? image = await _picker.pickImage(
      source: source,
      maxHeight: 1080,
      maxWidth: 1080,
      imageQuality: 90,
    );
    if (image != null) {
      provider.setImage(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

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

              // Foto de perfil
              Text('Foto de perfil',
                  style: GoogleFonts.poppins(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 12),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFBBBBBB),
                ),

                child: provider.selectedImage != null
                    ? ClipOval(
                  child: Image.file(
                    provider.selectedImage!,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                )
                    : const Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: AppColors.primary),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: AppColors.primary),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),

              const SizedBox(height: 28),
              VsTextField(label: 'Nombre de usuario', controller: _nombreUsuarioCtrl),
              const SizedBox(height: 14),
              VsTextField(label: 'Contraseña', controller: _passwordCtrl, obscureText: true),
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
                onPressed: () async {
                  await provider.register(
                    nombreUsuario: _nombreUsuarioCtrl.text,
                    password: _passwordCtrl.text,
                    rol: _selectedRol,
                  );

                  if (provider.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(provider.error!)),
                    );
                  } else {
                    AppNavigation.goToAddress(context);
                  }
                },
                child: provider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Continuar'),
              ),

              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => AppNavigation.goToLogin(context),
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
