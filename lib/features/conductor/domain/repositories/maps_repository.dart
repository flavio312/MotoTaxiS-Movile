import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapsRepository {
  Future<List<LatLng>> obtenerRuta(LatLng origen, LatLng destino);
}