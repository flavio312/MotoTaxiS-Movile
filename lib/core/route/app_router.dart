import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:viajeseguro/features/login/presentation/providers/auth_provider.dart';
import 'package:viajeseguro/features/login/presentation/page/login_screen.dart';
import 'package:viajeseguro/features/login/presentation/page/register_person_screen.dart';
import 'package:viajeseguro/features/addres/screens/addres_screen.dart';
import 'package:viajeseguro/features/profile/presentation/page/profile_screen.dart';
import 'package:viajeseguro/features/service/presentation/service_sreen.dart';
import 'package:viajeseguro/features/history/presentation/history_screen.dart';
import 'package:viajeseguro/features/trip/presentation/active_trip_screen.dart';
import 'package:viajeseguro/features/rating/presentation/rating_screen.dart';
import 'package:viajeseguro/features/settings/presentation/settings_screen.dart';
import 'package:viajeseguro/features/settings/presentation/privacy_screen.dart';
// --------CONDUCTOR-----------
import '../../features/conductor/presentation/page/registro_conductor_screen.dart';
import '../../features/conductor/presentation/page/home_conductor_screen.dart';
import '../../features/conductor/presentation/page/evaluar_usuario_screen.dart';
import '../../features/conductor/presentation/page/qr_conductor_screen.dart';
import '../../features/conductor/presentation/page/historial_conductor_screen.dart';
import '../../features/conductor/presentation/page/solicitud_entrante_screen.dart';
import '../../features/conductor/presentation/page/viaje_conductor_screen.dart';
import '../widgets/error_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

class AppRouter {
  final AuthProvider authProvider;

  AppRouter(this.authProvider);

  late final GoRouter router = GoRouter(
    refreshListenable: authProvider,
    initialLocation: RoutePaths.login,
    debugLogDiagnostics: true,

    redirect: (BuildContext context, GoRouterState state) {
      final isLoading = authProvider.isLoading;
      final isAuthenticated = authProvider.isAuthenticated;

      final isLogin = state.matchedLocation == RoutePaths.login;
      final isRegister = state.matchedLocation == RoutePaths.registerPerson;

      if (isLoading) {
        return isLogin ? null : RoutePaths.login;
      }

      if (!isAuthenticated) {
        if (isLogin || isRegister) return null;
        return RoutePaths.login;
      }

      if (isLogin || isRegister) {
        return RoutePaths.service;
      }

      return null;
    },

    routes: [
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.registerPerson,
        name: RouteNames.registerPerson,
        builder: (context, state) => const RegisterPersonScreen(),
      ),
      GoRoute(
        path: RoutePaths.address,
        name: RouteNames.address,
        builder: (context, state) => const AddressScreen(),
      ),
      GoRoute(
        path: RoutePaths.profile,
        name: RouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RoutePaths.service,
        name: RouteNames.service,
        builder: (context, state) => const ServiceScreen(),
        routes: [
          GoRoute(
            path: RoutePaths.history,
            name: RouteNames.history,
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: RoutePaths.activeTrip,
            name: RouteNames.activeTrip,
            builder: (context, state) => const ActiveTripScreen(),
          ),
          GoRoute(
            path: RoutePaths.rating,
            name: RouteNames.rating,
            builder: (context, state) => const RatingScreen(),
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: RoutePaths.privacy,
            name: RouteNames.privacy,
            builder: (context, state) => const PrivacyScreen(),
          ),
        ],
      ),
      // --------Conductor-----------------
      GoRoute(
        path: RoutePaths.registroConductor,
        name: RouteNames.registroConductor,
        builder: (context, state) => const RegistroConductorScreen(),
      ),
      GoRoute(
        path:RoutePaths.homeConductor,
        name: RouteNames.homeConductor,
        builder: (context, state) => const HomeConductorScreen(),
      ),
      GoRoute(
        path: RoutePaths.solicitudEntrante,
        name: RouteNames.solicitudEntrante,
        builder: (context, state) => const SolicitudEntranteScreen(),
      ),
      GoRoute(
        path: RoutePaths.viajeConductor,
        name: RouteNames.viajeConductor,
        builder: (context, state) => const ViajeConductorScreen(),
      ),
      GoRoute(
        path: RoutePaths.evaluarUsuario,
        name: RouteNames.evaluarUsuario,
        builder: (context, state) => const EvaluarUsuarioScreen(),
      ),
      GoRoute(
        path: RoutePaths.qrConductor,
        name: RouteNames.qrConductor,
        builder: (context, state) => const QrConductorScreen(),
      ),
      GoRoute(
        path: RoutePaths.historialConductor,
        name: RouteNames.historialConductor,
        builder: (context, state) => const HistorialConductorScreen(),
      )
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );
}
