import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

abstract class MapsDatasource {
  Future<List<LatLng>> obtenerRuta(LatLng origen, LatLng destino);
}

class MapsDatasourceImpl implements MapsDatasource {
  static const _apiKey = 'MAPS_API_KEY';

  @override
  Future<List<LatLng>> obtenerRuta(LatLng origen, LatLng destino) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${origen.latitude},${origen.longitude}'
          '&destination=${destino.latitude},${destino.longitude}'
          '&mode=driving'
          '&key=$_apiKey',
    );

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (data['status'] != 'OK') return [];

    final encoded = data['routes'][0]['overview_polyline']['points'] as String;
    final points = PolylinePoints.decodePolyline(encoded);

    return points.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }
}