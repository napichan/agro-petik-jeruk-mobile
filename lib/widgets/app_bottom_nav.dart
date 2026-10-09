import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../pages/beranda_page.dart';

/// Bottom navigation bar custom yang dipakai bersama di seluruh halaman utama.
///
/// Item navigasi:
/// Beranda  -> '/beranda'      (beranda_page.dart)
/// Tiket Saya -> '/pesan-tiket'(pesan_tiket_page.dart)
/// Scan (tengah) -> '/citrus-scan' (citrus_scan_page.dart)
/// Riwayat  -> '/riwayat'      (riwayat_page.dart)
/// Profile  -> '/profile'      (profile_page.dart)
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.activeIndex});

  /// Index item yang sedang aktif (0 = Beranda, 1 = Tiket Saya,
  /// 2 = Riwayat, 3 = Profile). Tombol scan di tengah tidak dihitung.
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.12),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(
            context,
            index: 0,
            iconData: Mdi.home,
            label: 'Beranda',
            route: '/beranda',
          ),
          _navItem(
            context,
            index: 1,
            iconData: Mdi.ticket_confirmation_outline,
            label: 'Tiket Saya',
            route: '/pesan-tiket',
          ),
          // Tombol Citrus Scan di tengah.
          _scanButton(context),
          _navItem(
            context,
            index: 2,
            iconData: Mdi.clipboard_text_outline,
            label: 'Riwayat',
            route: '/riwayat',
          ),
          _navItem(
            context,
            index: 3,
            iconData: Mdi.account_outline,
            label: 'Profile',
            route: '/profile',
          ),
        ],
      ),
    );
  }

  /// Item navigasi. Saat aktif: ikon putih di kotak oranye + label oranye.
  /// Saat tidak aktif: ikon + label abu-abu.
  Widget _navItem(
    BuildContext context, {
    required int index,
    required String iconData,
    required String label,
    required String route,
  }) {
    final aktif = index == activeIndex;

    return InkWell(
      key: ValueKey('nav$route'),
      borderRadius: BorderRadius.circular(12),
      onTap: () => _goTo(context, route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (aktif)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: kPrimaryOrange,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryOrange.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Iconify(iconData, color: Colors.white, size: 22),
              ),
            )
          else
            SizedBox(
              height: 40,
              child: Center(
                child: Iconify(iconData, color: Colors.grey.shade400, size: 26),
              ),
            ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: aktif ? kPrimaryOrange : Colors.grey.shade400,
              fontWeight: aktif ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// Tombol Citrus Scan hijau di tengah bottom nav.
  Widget _scanButton(BuildContext context) {
    return InkWell(
      key: const ValueKey('nav/citrus-scan'),
      borderRadius: BorderRadius.circular(16),
      onTap: () => _goTo(context, '/citrus-scan'),
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: kPrimaryGreen,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: kPrimaryGreen.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Iconify(Mdi.line_scan, color: Colors.white, size: 28),
        ),
      ),
    );
  }

  /// Navigasi ke rute tujuan; dilewati bila sudah berada di halaman tersebut
  /// agar tumpukan halaman (stack) tidak bertambah duplikat.
  void _goTo(BuildContext context, String route) {
    if (ModalRoute.of(context)?.settings.name == route) return;
    Navigator.pushNamed(context, route);
  }
}
