import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final appRouter = AppRouter(authProvider);

    return MaterialApp.router(
      title: 'MotoTaxi Seguro',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.router,
      theme: AppTheme.theme,
    );
  }
}