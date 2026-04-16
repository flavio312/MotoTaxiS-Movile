import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_logo_header.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../providers/person_provider.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';

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
  final _fechaNacimientoCtrl = TextEditingController();

  @override
  void dispose() {
    _nombresCtrl.dispose();
    _apellidoPCtrl.dispose();
    _apellidoMCtrl.dispose();
    _sexoCtrl.dispose();
    _telefonoCtrl.dispose();
    _correoCtrl.dispose();
    _fechaNacimientoCtrl.dispose();
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
                      child: DropdownButtonFormField<String>(
                        value: null,
                        decoration: const InputDecoration(labelText: 'Sexo'),
                        items: const [
                          DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                          DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
                          DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                        ],
                        onChanged: (value) {
                          _sexoCtrl.text = value ?? '';
                        },
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Seleccione sexo' : null,
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
                TextFormField(
                  controller: _fechaNacimientoCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      _fechaNacimientoCtrl.text =
                      "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    }
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Seleccione fecha' : null,
                ),const SizedBox(height: 12),

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
                      "fechaNacimiento": _fechaNacimientoCtrl.text,
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
                      return;
                    }
                    final rol = profileProvider.roleFromToken?.toLowerCase().trim();
                    print('ROL DETECTADO: $rol');
                    switch(rol){
                      case 'pasajero':
                        AppNavigation.goToService(context);
                        break;
                      case 'conductor':
                        AppNavigation.goToRegistroConductor(context);
                        break;
                      case 'propietario':
                        AppNavigation.goToRegistroPropietario(context);
                        break;
                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Rol no válido')),
                        );
                        AppNavigation.goToLogin(context);
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