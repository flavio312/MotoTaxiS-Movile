import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class AppNavigation {
  static void goToNamed(
      BuildContext context,
      String name, {
        Map<String, String>? pathParameters,
        Map<String, dynamic>? queryParameters,
        Object? extra,
      }) {
    context.goNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static void pushNamed(
      BuildContext context,
      String name, {
        Map<String, String>? pathParameters,
        Map<String, dynamic>? queryParameters,
        Object? extra,
      }) {
    context.pushNamed(
      name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  static void pop(BuildContext context, {dynamic result}) {
    context.pop(result);
  }

  static void replace(BuildContext context, String name) {
    context.replaceNamed(name);
  }

  static void goToLogin(BuildContext context) {
    context.goNamed(RouteNames.login);
  }

  static void goToRegister(BuildContext context) {
    context.goNamed(RouteNames.registerPerson);
  }

  static void goToService(BuildContext context) {
    context.goNamed(RouteNames.service);
  }

  static void goToHistory(BuildContext context) {
    context.goNamed(RouteNames.history);
  }
  static void goToActiveTrip(BuildContext context) {
    context.goNamed(RouteNames.activeTrip);
  }
  static void goToRating(BuildContext context) {
    context.goNamed(RouteNames.rating);
  }
  static void goToSettings(BuildContext context) {
    context.goNamed(RouteNames.settings);
  }
  static void goToPrivacy(BuildContext context) {
    context.goNamed(RouteNames.privacy);
  }
  static void goToAddress(BuildContext context) {
    context.goNamed(RouteNames.address);
  }
  static void goToProfile(BuildContext context) {
    context.goNamed(RouteNames.profile);
  }
  // --------Conductor-----------------
  static void gotToRegistroConductor(BuildContext context) {
    context.goNamed(RouteNames.registroConductor);
  }
  static void gotToHomeConductor(BuildContext context) {
    context.goNamed(RouteNames.homeConductor);
  }
  static void gotToSolicitudEntrante(BuildContext context) {
    context.goNamed(RouteNames.solicitudEntrante);
  }
  static void gotToViajeConductor(BuildContext context) {
    context.goNamed(RouteNames.viajeConductor);
  }
  static void gotToEvaluarUsuario(BuildContext context) {
    context.goNamed(RouteNames.evaluarUsuario);
  }
  static void gotToQrConductor(BuildContext context) {
    context.goNamed(RouteNames.qrConductor);
  }
  static void gotToHistorialConductor(BuildContext context) {
    context.goNamed(RouteNames.historialConductor);
  }

}
