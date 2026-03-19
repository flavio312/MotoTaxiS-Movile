import 'package:go_router/go_router.dart';
import 'package:viajeseguro/features/login/presentation/login_screen.dart';
import 'package:viajeseguro/features/login/presentation/register_screen.dart';
import 'package:viajeseguro/features/addres/screens/addres_screen.dart';
import 'package:viajeseguro/features/profile/presentation/profile_screen.dart';
import 'package:viajeseguro/features/service/presentation/service_sreen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String address = '/address';
  static const String profile = '/profile';
  static const String service = '/service';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.address,
      name: 'address',
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.service,
      name: 'service',
      builder: (context, state) => const ServiceScreen(),
    ),
  ],
);
