import 'package:go_router/go_router.dart';
import 'package:viajeseguro/features/login/presentation/login_screen.dart';
import 'package:viajeseguro/features/login/presentation/register_person_screen.dart';
import 'package:viajeseguro/features/addres/screens/addres_screen.dart';
import 'package:viajeseguro/features/profile/presentation/profile_screen.dart';
import 'package:viajeseguro/features/service/presentation/service_sreen.dart';
import 'package:viajeseguro/features/history/presentation/history_screen.dart';
import 'package:viajeseguro/features/trip/presentation/active_trip_screen.dart';
import 'package:viajeseguro/features/rating/presentation/rating_screen.dart';
import 'package:viajeseguro/features/settings/presentation/settings_screen.dart';
import 'package:viajeseguro/features/settings/presentation/privacy_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String registerPerson = '/registerPerson';
  static const String address = '/address';
  static const String profile = '/profile';
  static const String service = '/service';
  static const String history = '/history';
  static const String activeTrip = '/active-trip';
  static const String rating = '/rating';
  static const String settings = '/settings';
  static const String privacy = '/privacy';
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
        path: AppRoutes.registerPerson,
        name: 'registerPerson',
        builder: (context, state) => const RegisterPersonScreen()
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
    GoRoute(
        path: AppRoutes.history,
        name: 'history',
        builder: (context, state) => const HistoryScreen()
    ),
    GoRoute(
        path: AppRoutes.activeTrip,
        name: 'activeTrip',
        builder: (context, state) => const ActiveTripScreen()
    ),
    GoRoute(
        path: AppRoutes.rating,
        name: 'rating',
        builder: (context, state) => const RatingScreen()
    ),
    GoRoute(
        path: AppRoutes.settings,
        name: 'setings',
        builder: (context, state)=> const SettingsScreen()
    ),
    GoRoute(
        path: AppRoutes.privacy,
        name: 'privacy',
        builder: (context, state) => const PrivacyScreen())
  ],
);
