import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../widgets/app_bottom_nav.dart';
import 'beranda_page.dart';

/// Halaman Profile — sesuai desain UI "Profile".
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kBgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Kartu Identitas ──────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: kPrimaryOrange.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "HJ",
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryOrange,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Nama
                  Text(
                    "Haura Jasmine",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Email & No. HP
                  Text(
                    "Jasmine29@gmail.com • +62 812-3456-7890",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  // Badge Member Setia
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: kPrimaryGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified,
                          size: 14,
                          color: kPrimaryGreen,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Member Setia",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Statistik: Tiket, Kunjungan, Poin ────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _statItem(label: "Tiket Aktif", value: "1", color: Colors.black87),
                  _statDivider(),
                  _statItem(label: "Kunjungan", value: "4", color: Colors.black87),
                  _statDivider(),
                  _statItem(label: "Poin Kebun", value: "350", color: kPrimaryOrange),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Label Menu Akun ───────────────────────────────────
            Text(
              "MENU AKUN",
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                letterSpacing: 0.8,
              ),
            ),

            const SizedBox(height: 10),

            // ── Menu Akun ─────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _menuTile(
                    context,
                    icon: Mdi.account_outline,
                    label: "Informasi Akun",
                    onTap: () => _comingSoon(context, "Informasi Akun"),
                    isFirst: true,
                  ),
                  _divider(),
                  _menuTile(
                    context,
                    icon: Mdi.help_circle_outline,
                    label: "Pusat Bantuan",
                    onTap: () => _comingSoon(context, "Pusat Bantuan"),
                  ),
                  _divider(),
                  _menuTile(
                    context,
                    icon: Mdi.information_outline,
                    label: "Aturan & Info Kebun",
                    onTap: () => _comingSoon(context, "Aturan & Info Kebun"),
                    isLast: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Tombol Keluar Akun ────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                ),
                icon: const Icon(Icons.logout_rounded, color: kPrimaryOrange, size: 20),
                label: Text(
                  "Keluar Akun",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryOrange,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: const BorderSide(color: kPrimaryOrange, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      // Bottom navigation custom (item "Profile" sedang aktif).
      bottomNavigationBar: const AppBottomNav(activeIndex: 3),
    );
  }

  // ── Widget Helpers ───────────────────────────────────────────────

  static Widget _statItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _statDivider() => Container(
        width: 1,
        height: 40,
        color: Colors.grey.shade200,
      );

  static Widget _divider() =>
      Divider(height: 1, indent: 56, endIndent: 16, color: Colors.grey.shade100);

  static Widget _menuTile(
    BuildContext context, {
    required String icon,
    required String label,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.vertical(
        top: isFirst ? const Radius.circular(16) : Radius.zero,
        bottom: isLast ? const Radius.circular(16) : Radius.zero,
      ),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kPrimaryGreen.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Iconify(icon, color: kPrimaryGreen, size: 18),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade400,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  static void _comingSoon(BuildContext context, String fitur) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$fitur segera hadir'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
