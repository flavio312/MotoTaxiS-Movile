import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_logo_header.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../providers/person_provider.dart';

class RegisterPersonScreen extends StatefulWidget {
  const RegisterPersonScreen({super.key});

  @override
  State<RegisterPersonScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPersonScreen> {
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

  int _mapSexoToId(String sexo) {
    switch (sexo.toLowerCase()) {
      case 'masculino':
        return 1;
      case 'femenino':
        return 2;
      default:
        return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final personProvider = context.watch<PersonProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const VsLogoHeader(),
                const SizedBox(height: 24),

                VsTextField(label: 'Nombres', controller: _nombresCtrl),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: VsTextField(
                        label: 'Apellido Paterno',
                        controller: _apellidoPCtrl,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: VsTextField(
                        label: 'Apellido Materno',
                        controller: _apellidoMCtrl,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: VsTextField(
                        label: 'Sexo (Masculino/Femenino/Otro)',
                        controller: _sexoCtrl,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: VsTextField(
                        label: 'Teléfono',
                        controller: _telefonoCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                VsTextField(
                  label: 'Correo electrónico',
                  controller: _correoCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 28),

                ElevatedButton(
                  onPressed: personProvider.isLoading
                      ? null
                      : () async {
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
                      "nombre": _nombresCtrl.text,
                      "apellidoP": _apellidoPCtrl.text,
                      "apellidoM": _apellidoMCtrl.text,
                      "idSexo": _mapSexoToId(_sexoCtrl.text),
                      "correoElectronico": _correoCtrl.text,
                      "telefono": _telefonoCtrl.text,
                      "fechaNacimiento": "1997-12-23", // luego lo haces dinámico
                    };

                    await context.read<PersonProvider>().register(
                      data: data,
                      token: token,
                    );

                    if (context.read<PersonProvider>().error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(context.read<PersonProvider>().error!),
                        ),
                      );
                    } else {
                      AppNavigation.goToService(context);
                    }
                  },
                  child: personProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Registrar'),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}