import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../repositories/maps_repository.dart';

class ObtenerRutaUsecase {
  final MapsRepository repository;
  ObtenerRutaUsecase(this.repository);

  Future<List<LatLng>> call(LatLng origen, LatLng destino) =>
      repository.obtenerRuta(origen, destino);
}