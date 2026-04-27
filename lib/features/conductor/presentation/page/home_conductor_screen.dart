import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:viajeseguro/core/route/app_navigation.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import '../../data/models/solicitud_model.dart';
import '../providers/servicio_provider.dart';
import '../widgets/solicitud_card.dart';

class HomeConductorScreen extends StatefulWidget {
  final int idConductor;
  const HomeConductorScreen({super.key, required this.idConductor});

  @override
  State<HomeConductorScreen> createState() => _HomeConductorScreenState();
}

class _HomeConductorScreenState extends State<HomeConductorScreen> {
  bool _habilitado = true;

  // ── Lista vacía — se llena desde el socket ─────────────────────────────
  final List<SolicitudModel> _solicitudes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final socket = context.read<ServicioProvider>().socket;

      // 1. Registrar conductor en su sala
      context.read<ServicioProvider>().registrarConductor(widget.idConductor);

      // 2. Escuchar nuevas solicitudes que manda el backend
      socket.on('nuevaSolicitud', (data) {
        if (!mounted) return;
        try {
          final nueva = SolicitudModel.fromJson(
            Map<String, dynamic>.from(data as Map),
          );
          setState(() => _solicitudes.insert(0, nueva));
        } catch (e) {
          debugPrint('Error parseando solicitud: $e');
        }
      });

      // 3. Si el pasajero cancela antes de que el conductor acepte,
      //    eliminar la solicitud de la lista
      socket.on('servicioCancelado', (idServicio) {
        if (!mounted) return;
        setState(() {
          _solicitudes.removeWhere((s) => s.idServicio == idServicio);
        });
      });

      // 4. Si otro conductor ya tomó el servicio, quitarlo de la lista
      socket.on('servicioTomado', (data) {
        if (!mounted) return;
        final payload = Map<String, dynamic>.from(data as Map);
        final idServicio = payload['idServicio'] as int;
        setState(() {
          _solicitudes.removeWhere((s) => s.idServicio == idServicio);
        });
      });
    });
  }

  @override
  void dispose() {
    final socket = context.read<ServicioProvider>().socket;
    socket.off('nuevaSolicitud');
    socket.off('servicioCancelado');
    socket.off('servicioTomado');
    super.dispose();
  }

  void _toggleHabilitado(bool valor) {
    setState(() => _habilitado = valor);
    context.read<ServicioProvider>().socket.emit('estadoConductor', {
      'idConductor': widget.idConductor,
      'disponible':  valor,
    });

    // Si se deshabilita, limpiar solicitudes pendientes
    if (!valor) setState(() => _solicitudes.clear());
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Estatus ──────────────────────────────────────────
                    Text('Estatus',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _EstadoChip(
                          label: 'Habilitado',
                          isSelected: _habilitado,
                          onTap: () => _toggleHabilitado(true),
                        ),
                        const SizedBox(width: 10),
                        _EstadoChip(
                          label: 'Deshabilitado',
                          isSelected: !_habilitado,
                          onTap: () => _toggleHabilitado(false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => AppNavigation.goToQrConductor(context),
                        child: Text('Compartir informacion',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── Lista de solicitudes ─────────────────────────────
                    if (_solicitudes.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Icon(
                                _habilitado
                                    ? Icons.access_time_rounded
                                    : Icons.pause_circle_outline,
                                size: 48,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _habilitado
                                    ? 'Esperando solicitudes...'
                                    : 'Estás deshabilitado',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                    // Badge con el número de solicitudes pendientes
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_solicitudes.length} solicitud(es) pendiente(s)',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 8),
                          ..._solicitudes.map((s) => SolicitudCard(
                            solicitud: s,
                            onAceptar: () =>
                                AppNavigation.goToSolicitudEntrante(context),
                            onRechazar: () =>
                                setState(() => _solicitudes.remove(s)),
                          )),
                        ],
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

class _EstadoChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _EstadoChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDDDDDD) : Colors.transparent,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary)),
      ),
    );
  }
}