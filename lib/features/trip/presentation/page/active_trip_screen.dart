import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/features/conductor/presentation/providers/servicio_provider.dart';
import 'package:viajeseguro/features/conductor/presentation/providers/mapa_provider.dart';

class ActiveTripScreen extends StatefulWidget {
  final int idServicio;
  final double latOrigen;
  final double lngOrigen;
  final double latDestino;
  final double lngDestino;

  const ActiveTripScreen({
    super.key,
    required this.idServicio,
    required this.latOrigen,
    required this.lngOrigen,
    required this.latDestino,
    required this.lngDestino,
  });

  @override
  State<ActiveTripScreen> createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  final Completer<GoogleMapController> _mapCompleter = Completer();
  StreamSubscription<int>? _servicioTomadoSub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mapaProvider    = context.read<MapaProvider>();
      final servicioProvider = context.read<ServicioProvider>();

      // Escuchar cuando el conductor acepta (viene con coordenadas reales)
      servicioProvider.socket.once('servicioTomado', (data) {
        if (!mounted) return;

        final payload = Map<String, dynamic>.from(data as Map);

        mapaProvider.cargarRuta(
          LatLng((payload['latOrigen']  as num).toDouble(),
              (payload['lngOrigen']  as num).toDouble()),
          LatLng((payload['latDestino'] as num).toDouble(),
              (payload['lngDestino'] as num).toDouble()),
        );

        mapaProvider.unirseServicio(payload['idServicio'] as int);
        mapaProvider.escucharConductor();
      });
    });
  }

  @override
  void dispose() {
    _servicioTomadoSub?.cancel();
    context.read<MapaProvider>().limpiarEscuchas();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Center(
                child: Text('Viaje en curso',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // ── Google Map real ──────────────────────────────────
                    Consumer<MapaProvider>(
                      builder: (_, provider, __) => ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          height: 220,
                          child: Stack(
                            children: [
                              GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(widget.latOrigen, widget.lngOrigen),
                                  zoom: 15,
                                ),
                                markers: Set<Marker>.of(provider.markers.values),
                                polylines: Set<Polyline>.of(provider.polylines.values),
                                myLocationEnabled: false,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                                onMapCreated: (controller) {
                                  provider.mapController = controller;
                                  if (!_mapCompleter.isCompleted) {
                                    _mapCompleter.complete(controller);
                                  }
                                },
                              ),
                              // Indicador de carga mientras llega la ruta
                              if (provider.cargandoRuta)
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Info del viaje ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Punto verde parpadeante = conductor en línea
                                Consumer<MapaProvider>(
                                  builder: (_, p, __) => Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                      color: p.conductorConectado
                                          ? Colors.green
                                          : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Text('En curso',
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Conductor: DL Flavio',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text('Vehículo',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 12),
                          // Velocidad actual del conductor
                          Consumer<MapaProvider>(
                            builder: (_, p, __) => p.velocidadActual > 0
                                ? Text(
                              '${p.velocidadActual.toStringAsFixed(0)} km/h',
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.textSecondary),
                            )
                                : const SizedBox.shrink(),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Calle 12a ote. Sur',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Botones ──────────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () => AppNavigation.goToHistory(context),
                        child: Text('Cancelar servicio',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD32F2F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () {},
                        child: Text('Reportar incidente',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const VsBottomNav(currentIndex: 1),
          ],
        ),
      ),
    );
  }
}