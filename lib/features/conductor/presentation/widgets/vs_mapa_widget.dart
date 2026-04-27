import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/mapa_provider.dart';

class VsMapaWidget extends StatelessWidget {
  final LatLng posicionInicial;
  final double height;

  const VsMapaWidget({
    super.key,
    required this.posicionInicial,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Consumer<MapaProvider>(
          builder: (_, provider, __) => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: posicionInicial,
              zoom: 15,
            ),
            markers: Set<Marker>.of(provider.markers.values),
            polylines: Set<Polyline>.of(provider.polylines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (controller) {
              provider.mapController = controller;
            },
          ),
        ),
      ),
    );
  }
}