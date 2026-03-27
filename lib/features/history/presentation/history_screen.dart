import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viajeseguro/core/route/app_router.dart';
import 'package:viajeseguro/core/theme/app_theme.dart';
import 'package:viajeseguro/core/widgets/vs_bottom_nav.dart';

class TripHistoryItem {
  final String date;
  final String status;
  final String address;
  final String subAddress;
  final bool isActive;

  const TripHistoryItem({
    required this.date,
    required this.status,
    required this.address,
    required this.subAddress,
    this.isActive = false,
  });
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static final List<TripHistoryItem> _trips = [
    TripHistoryItem(
      date: '27/01/2026, 9:41 pm',
      status: 'Terminado',
      address: 'Calle primera centro 225',
      subAddress: 'Calle 12a ote. Sur',
    ),
    TripHistoryItem(
      date: '27/01/2026, 9:41 pm',
      status: 'En curso',
      address: 'Calle primera centro 225',
      subAddress: 'Calle 12a ote. Sur',
      isActive: true,
    ),
    TripHistoryItem(
      date: '27/01/2026, 9:41 pm',
      status: 'Terminado',
      address: 'Calle primera centro 225',
      subAddress: 'Calle 12a ote. Sur',
    ),
    TripHistoryItem(
      date: '27/01/2026, 9:41 pm',
      status: 'Terminado',
      address: 'Calle primera centro 225',
      subAddress: 'Calle 12a ote. Sur',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _trips.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final trip = _trips[index];
                  return _TripCard(
                    trip: trip,
                    onTap: () => context.go(AppRoutes.activeTrip),
                  );
                },
              ),
            ),
            const VsBottomNav(currentIndex: 2),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'Viajes solicitados',
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Container(height: 3, color: AppColors.primary),
      ],
    );
  }
}

class _TripCard extends StatelessWidget {
  final TripHistoryItem trip;
  final VoidCallback onTap;

  const _TripCard({required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${trip.date}  ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        trip.status,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: trip.isActive
                              ? AppColors.primary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    trip.address,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    trip.subAddress,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
