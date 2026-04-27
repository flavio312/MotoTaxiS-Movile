import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import '../providers/mapa_provider.dart';

class ViajeConductorScreen extends StatefulWidget {
  final int idServicio;
  final int idConductor;
  final double latOrigen;
  final double lngOrigen;
  final double latDestino;
  final double lngDestino;

  const ViajeConductorScreen({
    super.key,
    required this.idServicio,
    required this.idConductor,
    required this.latOrigen,
    required this.lngOrigen,
    required this.latDestino,
    required this.lngDestino,
  });

  @override
  State<ViajeConductorScreen> createState() => _ViajeConductorScreenState();
}

class _ViajeConductorScreenState extends State<ViajeConductorScreen> {
  final Completer<GoogleMapController> _mapCompleter = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MapaProvider>();

      // 1. Cargar ruta origen → destino en el mapa
      provider.cargarRuta(
        LatLng(widget.latOrigen, widget.lngOrigen),
        LatLng(widget.latDestino, widget.lngDestino),
      );

      // 2. Iniciar GPS y emitir tracking por socket
      provider.iniciarTracking(widget.idServicio, widget.idConductor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ─────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Conductor',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('Nombre',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ],
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
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(widget.latOrigen, widget.lngOrigen),
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
                              if (!_mapCompleter.isCompleted) {
                                _mapCompleter.complete(controller);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Info del viaje ───────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Consumer<MapaProvider>(
                              builder: (_, p, __) => Text(
                                p.velocidadActual > 0
                                    ? '${p.velocidadActual.toStringAsFixed(0)} km/h'
                                    : 'En curso',
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('Pasajero: DL Flavio',
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('Tipo de servicio: Transporte',
                              style: GoogleFonts.poppins(fontSize: 13)),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Calle 12a ote. Sur',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Botones ──────────────────────────────────────────
                    _ServiceBtn(
                      label: 'TERMINAR EL SERVICIO',
                      icon: Icons.lock_outline,
                      color: const Color(0xFF2C2C2C),
                      textColor: Colors.white,
                      onTap: () {
                        context.read<MapaProvider>().detenerTracking();
                        AppNavigation.goToEvaluarUsuario(context);
                      },
                    ),
                    const SizedBox(height: 10),
                    _ServiceBtn(
                      label: 'Suspender servicio',
                      color: AppColors.primary,
                      textColor: Colors.white,
                      onTap: () {
                        context.read<MapaProvider>().detenerTracking();
                        AppNavigation.goToHomeConductor(context);
                      },
                    ),
                    const SizedBox(height: 10),
                    _ServiceBtn(
                      label: 'Reportar incidente',
                      color: const Color(0xFFD32F2F),
                      textColor: Colors.white,
                      onTap: () {},
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

// ── Botón reutilizable ────────────────────────────────────────────────────
class _ServiceBtn extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _ServiceBtn({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 18),
              const SizedBox(width: 8),
            ],
            Text(label,
                style: GoogleFonts.poppins(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}