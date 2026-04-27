import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import '../../data/models/solicitud_model.dart';
import '../providers/servicio_provider.dart';
import '../widgets/solicitud_card.dart';

class SolicitudEntranteScreen extends StatefulWidget {
  // La solicitud activa llega desde HomeConductorScreen al navegar
  final SolicitudModel solicitudActiva;
  final List<SolicitudModel> otras;

  const SolicitudEntranteScreen({
    super.key,
    required this.solicitudActiva,
    this.otras = const [],
  });

  @override
  State<SolicitudEntranteScreen> createState() =>
      _SolicitudEntranteScreenState();
}

class _SolicitudEntranteScreenState extends State<SolicitudEntranteScreen> {
  late SolicitudModel _solicitudActiva;
  late List<SolicitudModel> _otras;
  bool _aceptando = false;

  @override
  void initState() {
    super.initState();
    // Inicializar desde los parámetros — nunca null
    _solicitudActiva = widget.solicitudActiva;
    _otras = List.from(widget.otras);
  }

  Future<void> _aceptar() async {
    if (_aceptando) return;
    setState(() => _aceptando = true);

    try {
      context.read<ServicioProvider>().aceptarServicio(
        _solicitudActiva.idServicio,
        _solicitudActiva.idConductor,
      );

      context.read<ServicioProvider>().socket.once(
        'servicioAceptado',
            (data) {
          if (!mounted) return;

          final payload = Map<String, dynamic>.from(data as Map);

          // Las coords vienen como String desde tu modelo
          /*AppNavigation.goToViajeConductor(
            context,
            idServicio:  payload['idServicio']  as int,
            idConductor: payload['idConductor'] as int,
            latOrigen:   payload['latOrigen'].toString(),
            lngOrigen:   payload['lngOrigen'].toString(),
            latDestino:  payload['latDestino'].toString(),
            lngDestino:  payload['lngDestino'].toString(),
          );*/
        },
      );

      context.read<ServicioProvider>().socket.once('errorServicio', (msg) {
        if (!mounted) return;
        setState(() => _aceptando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: $msg'), backgroundColor: Colors.red),
        );
      });
    } catch (e) {
      setState(() => _aceptando = false);
    }
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
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Solicitud entrante',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  // Ya no es nullable — viene del constructor
                  Text(
                    _solicitudActiva.conductor,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Container(height: 3, color: AppColors.primary),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Solicitud activa ─────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tipo de servicio: ${_solicitudActiva.tipoPaquete}',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text('Origen',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: AppColors.textSecondary)),
                                    Text(
                                      _solicitudActiva.origen,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('Destino',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: AppColors.textSecondary)),
                                    Text(
                                      _solicitudActiva.destino,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _BigActionBtn(
                                  label: _aceptando
                                      ? 'Aceptando...'
                                      : 'Aceptar',
                                  color: Colors.green,
                                  onTap: _aceptando ? () {} : _aceptar,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _BigActionBtn(
                                  label: 'Rechazar',
                                  color: Colors.red,
                                  onTap: () =>
                                      AppNavigation.goToHomeConductor(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Otras solicitudes en cola ────────────────────────
                    ..._otras.map((s) => SolicitudCard(
                      solicitud: s,
                      onAceptar: () => setState(() {
                        _solicitudActiva = s;
                        _otras.remove(s);
                      }),
                      onRechazar: () =>
                          setState(() => _otras.remove(s)),
                    )),
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

class _BigActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _BigActionBtn(
      {required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(label,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}