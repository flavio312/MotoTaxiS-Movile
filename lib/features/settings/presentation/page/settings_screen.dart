import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static final List<_SettingsOption> _options = [
    _SettingsOption(label: 'Nombre de usuario', route: null),
    _SettingsOption(label: 'Correo electronico', route: null),
    _SettingsOption(label: 'Telefono', route: null),
    _SettingsOption(label: 'Lugares favoritos', route: null),
    _SettingsOption(label: 'Eliminar cuenta', route: '/privacy', isDestructive: true),
    _SettingsOption(label: 'Terminos y condiciones', route: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Avatar
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD1C4E9),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 52,
                      color: Color(0xFF7E57C2),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Menu options
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemCount: _options.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1, thickness: 1,
                        color: Color(0xFFEEEEEE),
                        indent: 20, endIndent: 20,
                      ),
                      itemBuilder: (context, index) {
                        final opt = _options[index];
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
                    onTap: () => AppNavigation.goToLogin(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cerrar sesion',
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary),
                          ),
                        ],
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
  final String? route;
  final bool isDestructive;

  const _SettingsOption({
    required this.label,
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
