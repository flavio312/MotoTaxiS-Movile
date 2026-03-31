import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';
import 'package:viajeseguro/core/widgets/vs_text_field.dart';
import '../../../../core/route/app_navigation.dart';

class RegistroConductorScreen extends StatefulWidget {
  const RegistroConductorScreen({super.key});

  @override
  State<RegistroConductorScreen> createState() => _RegistroConductorScreenState();
}

class _RegistroConductorScreenState extends State<RegistroConductorScreen> {
  final _licenciaCtrl       = TextEditingController();
  final _fechaExpedicionCtrl = TextEditingController();
  final _fechaVencimientoCtrl = TextEditingController();

  int _inicioHora = 8;
  int _inicioMin  = 0;
  int _finHora    = 16;
  int _finMin     = 0;

  @override
  void dispose() {
    _licenciaCtrl.dispose();
    _fechaExpedicionCtrl.dispose();
    _fechaVencimientoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text('Registro de conductor',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
            ),
            Container(height: 3, color: AppColors.primary),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Logo box ─────────────────────
                    Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.motorcycle, color: Colors.white, size: 42),
                          const SizedBox(height: 4),
                          Text('ViajeSeguro',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Licencia ─────────────────────
                    VsTextField(
                      label: 'Licencia de conducir',
                      controller: _licenciaCtrl,
                    ),
                    const SizedBox(height: 14),

                    // ── Fechas ───────────────────────
                    Row(
                      children: [
                        Expanded(child: VsTextField(
                          label: 'Fecha de expedicion',
                          controller: _fechaExpedicionCtrl,
                          keyboardType: TextInputType.datetime,
                        )),
                        const SizedBox(width: 10),
                        Expanded(child: VsTextField(
                          label: 'Fecha de vencimiento',
                          controller: _fechaVencimientoCtrl,
                          keyboardType: TextInputType.datetime,
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Horario laboral ──────────────
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Horario laboral',
                          style: GoogleFonts.poppins(
                              fontSize: 13, fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Inicio
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Inicio',
                                  style: GoogleFonts.poppins(fontSize: 12,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              _HorarioSelector(
                                hora: _inicioHora,
                                minuto: _inicioMin,
                                onHoraChanged: (v) => setState(() => _inicioHora = v),
                                onMinutoChanged: (v) => setState(() => _inicioMin = v),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Fin
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Fin',
                                  style: GoogleFonts.poppins(fontSize: 12,
                                      color: AppColors.textSecondary)),
                              const SizedBox(height: 6),
                              _HorarioSelector(
                                hora: _finHora,
                                minuto: _finMin,
                                onHoraChanged: (v) => setState(() => _finHora = v),
                                onMinutoChanged: (v) => setState(() => _finMin = v),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // ── Guardar ──────────────────────
                    ElevatedButton(
                      onPressed: () => AppNavigation.gotToHomeConductor(context),
                      child: const Text('Guardar'),
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

// ── Widget selector de hora:minuto ───────────────────────────────────────────
class _HorarioSelector extends StatelessWidget {
  final int hora;
  final int minuto;
  final ValueChanged<int> onHoraChanged;
  final ValueChanged<int> onMinutoChanged;

  const _HorarioSelector({
    required this.hora,
    required this.minuto,
    required this.onHoraChanged,
    required this.onMinutoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Hora
        _DropdownTime(
          value: hora,
          items: List.generate(24, (i) => i),
          onChanged: onHoraChanged,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(':', style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
        ),
        // Minuto
        _DropdownTime(
          value: minuto,
          items: [0, 15, 30, 45],
          onChanged: onMinutoChanged,
          labelBuilder: (v) => v.toString().padLeft(2, '0'),
        ),
      ],
    );
  }
}

class _DropdownTime extends StatelessWidget {
  final int value;
  final List<int> items;
  final ValueChanged<int> onChanged;
  final String Function(int)? labelBuilder;

  const _DropdownTime({
    required this.value,
    required this.items,
    required this.onChanged,
    this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isDense: true,
          items: items.map((v) => DropdownMenuItem(
            value: v,
            child: Text(
              labelBuilder != null ? labelBuilder!(v) : v.toString(),
              style: GoogleFonts.poppins(fontSize: 13),
            ),
          )).toList(),
          onChanged: (v) { if (v != null) onChanged(v); },
        ),
      ),
    );
  }
}
