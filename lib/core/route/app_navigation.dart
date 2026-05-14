import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';
import '../../features/conductor/data/models/solicitud_model.dart';

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
  static void goToHistorialAddress(BuildContext context) {
    context.goNamed(RouteNames.historialaddress);
  }
  static void goToProfile(BuildContext context) {
    context.goNamed(RouteNames.profile);
  }
  // --------Conductor-----------------
  static void goToRegistroConductor(BuildContext context) {
    context.goNamed(RouteNames.registroConductor);
  }
  static void goToJornadaConductor(BuildContext context) {
    context.goNamed(RouteNames.jornadaConductor);
  }
  static void goToHomeConductor(BuildContext context, {required int idConductor}) {
    context.goNamed(RouteNames.homeConductor,
    extra: {'idConductor': idConductor},
    );
  }
  static void goToSolicitudEntrante(BuildContext context,{
    required SolicitudModel solicitudActiva,
    List<SolicitudModel> otras = const []
  }) {
    context.goNamed(RouteNames.solicitudEntrante,
    extra: {
      'solicitudActiva':solicitudActiva,
      'otras':otras,
    },);
  }
  static void goToViajeConductor(BuildContext context,{
    required int    idServicio,
    required int    idConductor,
    required String latOrigen,
    required String lngOrigen,
    required String latDestino,
    required String lngDestino,
  }) {
    context.goNamed(RouteNames.viajeConductor,
    extra: {
      'idServicio': idServicio,
      'idConductor': idConductor,
      'latOrigen': latOrigen,
      'lngOrigen': lngOrigen,
      'latDestino': latDestino,
      'lngDestino': lngDestino,});
  }
  static void goToEvaluarUsuario(BuildContext context) {
    context.goNamed(RouteNames.evaluarUsuario);
  }
  static void goToQrConductor(BuildContext context) {
    context.goNamed(RouteNames.qrConductor);
  }
  static void goToHistorialConductor(BuildContext context) {
    context.goNamed(RouteNames.historialConductor);
  }
  // Propietatio
  static void goToRegistroPropietario(BuildContext context) {
    context.goNamed(RouteNames.registroPropietario);
  }
  static void goToHomePropietario(BuildContext context) {
    context.goNamed(RouteNames.homePropietario);
  }
  static void goToAgregarVehiculo(BuildContext context) {
    context.goNamed(RouteNames.agregarVehiculo);
  }
  static void goToDetalleVehiculo(BuildContext context) {
    context.goNamed(RouteNames.detalleVehiculo);
  }
  static void goToAsignarVehiculo(BuildContext context) {
    context.goNamed(RouteNames.asignarVehiculo);
  }
  static void goToEscanearQr(BuildContext context) {
    context.goNamed(RouteNames.escanearQr);
  }
}
