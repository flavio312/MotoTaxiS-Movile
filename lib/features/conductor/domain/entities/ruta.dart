import 'package:google_maps_flutter/google_maps_flutter.dart';

class RutaEntity {
  final List<LatLng> puntos;
  final LatLng origen;
  final LatLng destino;
  final LatLng? conductor;

  const RutaEntity({
    required this.puntos,
    required this.origen,
    required this.destino,
    this.conductor,
  });

  RutaEntity copyWith({LatLng? conductor}) => RutaEntity(
    puntos: puntos,
    origen: origen,
    destino: destino,
    conductor: conductor ?? this.conductor,
  );
}