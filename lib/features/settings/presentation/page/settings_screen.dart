import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';
import '../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final token = context.read<AuthProvider>().token;
      if (token != null) {
        context.read<UserProfileProvider>().loadProfile(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<UserProfileProvider>();
    final profile = profileProvider.profile;

    final options = [
      _SettingsOption(label: profile?.nombreUsuario ?? '—', sublabel: 'Nombre de usuario', route: null),
      _SettingsOption(label: profile?.correoElectronico ?? '—', sublabel: 'Correo electrónico', route: null),
      _SettingsOption(label: profile?.telefono ?? '—', sublabel: 'Teléfono', route: null),
      _SettingsOption(label: 'Lugares favoritos', route: null),
      _SettingsOption(label: 'Eliminar cuenta', route: '/privacy', isDestructive: true),
      _SettingsOption(label: 'Términos y condiciones', route: null),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: profileProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                children: [
                  const SizedBox(height: 32),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD1C4E9),
                    ),
                    child: profile?.fotoPerfil != null && profile!.fotoPerfil!.isNotEmpty
                        ? ClipOval(
                      child: Image.network(
                        profile.fotoPerfil!,
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person_outline,
                              size: 52, color: Color(0xFF7E57C2));
                        },
                      ),
                    )
                        : const Icon(Icons.person_outline,
                        size: 52, color: Color(0xFF7E57C2)),
                  ),
                  const SizedBox(height: 8),
                  if (profile != null)
                    Text(
                      profile.nombreUsuario,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: options.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1, thickness: 1,
                        color: Color(0xFFEEEEEE),
                        indent: 20, endIndent: 20,
                      ),
                      itemBuilder: (context, index) {
                        final opt = options[index];
                        return _SettingsRow(
                          option: opt,
                          onTap: opt.route != null
                              ? () => context.go(opt.route!)
                              : () {},
                        );
                      },
                    ),
                  ),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                  InkWell(
                    onTap: () async {
                      await context.read<AuthProvider>().logout();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Center(
                        child: Text('Cerrar sesión',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const VsBottomNav(currentIndex: 1),
          ],
        ),
      ),
    );
  }
}
class _SettingsOption {
  final String label;
  final String? sublabel;
  final String? route;
  final bool isDestructive;

  const _SettingsOption({
    required this.label,
    this.sublabel,
    required this.route,
    this.isDestructive = false,
  });
}

class _SettingsRow extends StatelessWidget {
  final _SettingsOption option;
  final VoidCallback onTap;

  const _SettingsRow({required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            if (option.route != null)
              const Icon(Icons.chevron_right,
                  color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}
