import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';

class VsBottomNav extends StatelessWidget {
  final int currentIndex;
  const VsBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navBarBg,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            index: 0,
            current: currentIndex,
            onTap: () => AppNavigation.goToService(context),
          ),
          _NavItem(
            icon: Icons.directions_car_outlined,
            index: 1,
            current: currentIndex,
            onTap: () => AppNavigation.goToActiveTrip(context),
          ),
          _NavItem(
            icon: Icons.receipt_outlined,
            index: 2,
            current: currentIndex,
            onTap: () => AppNavigation.goToHistory(context),
          ),
          _NavItem(
            icon: Icons.person_add_alt_outlined,
            index: 3,
            current: currentIndex,
            onTap: () => AppNavigation.goToSettings(context),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int current;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == current;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Icon(
          icon,
          size: 26,
          color: isActive ? AppColors.navBarActive : AppColors.navBarInactive,
        ),
      ),
    );
  }
}
