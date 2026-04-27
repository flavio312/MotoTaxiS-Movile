import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/repositories/maps_repository.dart';
import '../datasource/maps_datasource.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsDatasource datasource;
  MapsRepositoryImpl(this.datasource);

  @override
  Future<List<LatLng>> obtenerRuta(LatLng origen, LatLng destino) =>
      datasource.obtenerRuta(origen, destino);
}