import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../domain/entities/ubicacion.dart';
import '../../domain/usecase/aceptar_servicio_usecase.dart';
import '../../domain/usecase/emitir_tracking_usecase.dart';
import '../../domain/usecase/escuchar_ubicacion_usecase.dart';
import '../../domain/repositories/servicio_repository.dart';

class ServicioProvider extends ChangeNotifier {
  final AceptarServicioUsecase _aceptarServicio;
  final EmitirTrackingUsecase _emitirTracking;
  final EscucharUbicacionUsecase _escucharUbicacion;
  final ServicioRepository _repository;

  final IO.Socket socket;

  UbicacionEntity? ubicacionConductor;
  StreamSubscription<Position>? _geoSub;
  StreamSubscription<UbicacionEntity>? _socketSub;

  ServicioProvider({
    required AceptarServicioUsecase aceptarServicio,
    required EmitirTrackingUsecase emitirTracking,
    required EscucharUbicacionUsecase escucharUbicacion,
    required ServicioRepository repository,
    required this.socket,
  })  : _aceptarServicio = aceptarServicio,
        _emitirTracking = emitirTracking,
        _escucharUbicacion = escucharUbicacion,
        _repository = repository;

  // Conductor: acepta un servicio
  void aceptarServicio(int idServicio, int idConductor) {
    _aceptarServicio(idServicio, idConductor);
  }

  // Conductor: inicia a emitir GPS
  void iniciarTracking(int idServicio, int idConductor) {
    _geoSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((pos) {
      final ubicacion = UbicacionEntity(
        latitud: pos.latitude,
        longitud: pos.longitude,
        velocidad: pos.speed * 3.6,
      );
      _emitirTracking(idServicio, ubicacion);
    });
  }

  // Pasajero: escucha la ubicación del conductor
  void escucharUbicacion() {
    _socketSub = _escucharUbicacion().listen((ubicacion) {
      ubicacionConductor = ubicacion;
      notifyListeners();
    });
  }

  // Conductor: registrarse al conectar
  void registrarConductor(int idConductor) {
    _repository.registrarConductor(idConductor);
  }

  // Pasajero: escucha cuando el servicio fue tomado
  Stream<int> get servicioTomadoStream =>
      _repository.escucharServicioTomado();

  @override
  void dispose() {
    _geoSub?.cancel();
    _socketSub?.cancel();
    super.dispose();
  }
}