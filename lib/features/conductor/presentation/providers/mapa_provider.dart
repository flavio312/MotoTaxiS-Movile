import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/ubicacion.dart';
import '../../domain/usecase/emitir_tracking_usecase.dart';
import '../../domain/usecase/escuchar_ubicacion_usecase.dart';
import '../../domain/usecase/obtener_ruta_usecase.dart';
import 'package:viajeseguro/features/conductor/domain/repositories/servicio_repository.dart';

class MapaProvider extends ChangeNotifier {
  final ObtenerRutaUsecase _obtenerRuta;
  final EmitirTrackingUsecase _emitirTracking;
  final EscucharUbicacionUsecase _escucharUbicacion;
  final ServicioRepository _repository;

  double velocidadActual = 0.0;
  bool conductorConectado = false;
  bool cargandoRuta = false;

  GoogleMapController? mapController;

  final Map<MarkerId, Marker> markers = {};

  LatLng? _posConductor;

  final Map<PolylineId, Polyline> polylines = {};
  LatLng? get posConductor => _posConductor;

  StreamSubscription<Position>? _geoSub;
  StreamSubscription<UbicacionEntity>? _socketSub;

  MapaProvider({
    required ObtenerRutaUsecase obtenerRuta,
    required EmitirTrackingUsecase emitirTracking,
    required EscucharUbicacionUsecase escucharUbicacion,
    required ServicioRepository repository,
  })  : _obtenerRuta = obtenerRuta,
        _emitirTracking = emitirTracking,
        _escucharUbicacion = escucharUbicacion,
        _repository = repository;

  Future<void> cargarRuta(LatLng origen, LatLng destino) async {
    _agregarMarcador('origen', origen, BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
    _agregarMarcador('destino', destino, BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));

    final puntos = await _obtenerRuta(origen, destino);
    if (puntos.isEmpty) return;

    const id = PolylineId('ruta');
    polylines[id] = Polyline(
      polylineId: id,
      color: const Color(0xFFFFBF00),
      width: 5,
      points: puntos,
    );

    final bounds = _boundsFromLatLngList(puntos);
    mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));

    notifyListeners();
  }

  void iniciarTracking(int idServicio, int idConductor) {
    _geoSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
      ),
    ).listen((pos) {
      final latLng = LatLng(pos.latitude, pos.longitude);
      velocidadActual = pos.speed * 3.6;
      _emitirTracking(
        idServicio,
        UbicacionEntity(
          latitud: pos.latitude,
          longitud: pos.longitude,
          velocidad: pos.speed * 3.6,
        ),
      );

      _actualizarMarcadorConductor(latLng);

      mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
      notifyListeners();
    });
  }
  void unirseServicio(int idServicio) {
    // repositorio/datasource emite 'unirseServicio' al socket
    _repository.unirseServicio(idServicio);
  }
  void detenerTracking() {
    _geoSub?.cancel();
    velocidadActual = 0;
    notifyListeners();
  }
  void limpiarEscuchas() {
    _socketSub?.cancel();
    conductorConectado = false;
  }

  void escucharConductor() {
    _socketSub = _escucharUbicacion().listen((ubicacion) {
      conductorConectado = true;
      velocidadActual = ubicacion.velocidad;
      final latLng = LatLng(ubicacion.latitud, ubicacion.longitud);
      _posConductor = latLng;
      _actualizarMarcadorConductor(latLng);
      mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
      notifyListeners();
    });
  }

  void _agregarMarcador(String id, LatLng pos, BitmapDescriptor icono) {
    final mId = MarkerId(id);
    markers[mId] = Marker(markerId: mId, position: pos, icon: icono);
    notifyListeners();
  }

  void _actualizarMarcadorConductor(LatLng pos) {
    const mId = MarkerId('conductor');
    markers[mId] = Marker(
      markerId: mId,
      position: pos,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: const InfoWindow(title: 'Conductor'),
    );
    notifyListeners();
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double minLat = list[0].latitude, maxLat = list[0].latitude;
    double minLng = list[0].longitude, maxLng = list[0].longitude;
    for (final p in list) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  void dispose() {
    _geoSub?.cancel();
    _socketSub?.cancel();
    mapController?.dispose();
    super.dispose();
  }
}