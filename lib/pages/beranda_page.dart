import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'beranda_data.dart';

/// Warna utama dari desain.
const Color kPrimaryOrange = Color(0xFFFF7A00);
const Color kPrimaryGreen = Color(0xFF1B8A44);
const Color kBgColor = Color(0xFFF9F9F9);

/// Gambar lokal untuk banner & kartu aktivitas (kebun jeruk).
const String _kKebunAsset = 'assets/images/Kebun Jeruk Solorejo.png';

/// Halaman beranda — sesuai desain UI "Beranda".
class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      // Custom Bottom Navigation Bar dengan tombol Citrus Scan di tengah.
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildHeroBanner(),
              const SizedBox(height: 24),
              _buildJelajahiMenu(),
              const SizedBox(height: 24),
              _buildAktivitasPopuler(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HEADER (Lokasi, Sapaan, Lonceng Notifikasi) ---
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: kPrimaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'WISATA ALAM SOLOREJO, MALANG',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryGreen,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            // Tombol Notifikasi -> halaman Notifikasi.
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => Navigator.pushNamed(context, '/notifikasi'),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Iconify(
                  Mdi.bell_outline,
                  color: kPrimaryOrange,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Halo Haura',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          'Ayo! Jelajahi aktivitas',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // --- WIDGET HERO BANNER (gambar asset + gradasi + label) ---
  Widget _buildHeroBanner() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(_kKebunAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withValues(alpha: 0.75),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: kPrimaryOrange.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'MUSIM PANEN RAYA',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Waktu terbaik untuk petik jeruk',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Cari tahu saat jeruk manis siap dipetik langsung dari...',
              style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET MENU JELAJAHI ---
  Widget _buildJelajahiMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jelajahi Sekarang',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kPrimaryOrange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Fitur Utama',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: kPrimaryOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _menuItem(
                iconData: Mdi.ticket_confirmation_outline,
                title: 'Pesan\nTiket',
                iconColor: kPrimaryOrange,
                // Pesan Tiket -> alur pemesanan tiket.
                onTap: () => Navigator.pushNamed(context, '/pesan-tiket'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _menuItem(
                iconData: Mdi.map_search_outline,
                title: 'Jelajahi\nAktivitas',
                iconColor: kPrimaryGreen,
                // Jelajahi Aktivitas -> halaman daftar aktivitas.
                onTap: () => Navigator.pushNamed(context, '/aktivitas'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _menuItem(
                iconData: Mdi.message_processing_outline,
                title: 'ChatBot AI',
                iconColor: kPrimaryOrange,
                // Halaman chatbot belum tersedia.
                onTap: () => _showComingSoon('ChatBot AI'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Kartu menu: ikon di dalam kotak rounded berwarna tint + label di bawah.
  Widget _menuItem({
    required String iconData,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Iconify(iconData, color: iconColor, size: 28),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET AKTIVITAS POPULER (kartu gambar + rating + harga + Pesan) ---
  Widget _buildAktivitasPopuler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktivitas Populer',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          'Pilihan favorit pengunjung minggu ini',
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: daftarAktivitasPopuler.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, i) =>
                _aktivitasCard(daftarAktivitasPopuler[i]),
          ),
        ),
      ],
    );
  }

  /// Kartu aktivitas: gambar kebun dengan chip Populer + rating,
  /// lalu judul, deskripsi, dan baris harga + tombol Pesan.
  Widget _aktivitasCard(AktivitasPopuler item) {
    return Container(
      width: 250,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar dengan chip Populer & rating di atasnya.
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: AssetImage(item.image),
                  fit: BoxFit.cover,
                ),
                // Chip Populer (oranye) + chip label hijau (Makan Sepuasnya, dll).
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      _chipPopuler(),
                      const SizedBox(width: 6),
                      if (item.chipLabel.isNotEmpty)
                        Flexible(child: _chipLabel(item.chipLabel)),
                    ],
                  ),
                ),
                // Rating chip di pojok kiri bawah gambar.
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _chipRating(item),
                ),
              ],
            ),
          ),
          // Info aktivitas.
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.deskripsi,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    height: 1.5,
                    color: Colors.grey.shade500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Harga.
                    Text.rich(
                      TextSpan(
                        text: _rupiah(item.harga),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: kPrimaryOrange,
                        ),
                        children: [
                          TextSpan(
                            text: ' /orang',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Tombol Pesan.
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Navigator.pushNamed(context, '/pesan-tiket'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kPrimaryGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Pesan',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Chip "Populer" oranye dengan ikon bintang.
  Widget _chipPopuler() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kPrimaryOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.white, size: 10),
          const SizedBox(width: 4),
          Text(
            'Populer',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Chip label hijau, mis. "Makan Sepuasnya" atau "Bawa Bibit".
  Widget _chipLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kPrimaryGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// Chip rating hijau muda, mis. "4.7".
  Widget _chipRating(AktivitasPopuler item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 10),
          const SizedBox(width: 4),
          Text(
            item.rating,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- FORMAT RUPIAH ---
  String _rupiah(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      buf.write(s[i]);
      final sisa = s.length - i - 1;
      if (sisa > 0 && sisa % 3 == 0) buf.write('.');
    }
    return 'Rp $buf';
  }

  // --- CUSTOM BOTTOM NAVIGATION BAR ---
  Widget _buildBottomNav() {
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
          // Beranda (aktif) — ikon di dalam kotak oranye.
          _navItemActive(Mdi.home, 'Beranda'),
          _navItem(
            Mdi.ticket_confirmation_outline,
            'Tiket',
            // Tiket -> halaman Tiket Saya.
            onTap: () => Navigator.pushNamed(context, '/tiket'),
          ),
          // Tombol Citrus Scan di tengah.
          _scanButton(),
          _navItem(
            Mdi.clipboard_text_outline,
            'Riwayat',
            // Riwayat -> halaman Riwayat Kunjungan.
            onTap: () => Navigator.pushNamed(context, '/riwayat'),
          ),
          _navItem(
            Mdi.account_outline,
            'Profile',
            // Profile -> halaman Profile.
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
    );
  }

  /// Item navigasi aktif: ikon putih di kotak oranye + label oranye.
  Widget _navItemActive(String iconData, String label) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: kPrimaryOrange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Item navigasi nonaktif: ikon + label abu-abu.
  Widget _navItem(String iconData, String label, {VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Center(
              child: Iconify(iconData, color: Colors.grey.shade400, size: 26),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  /// Tombol Citrus Scan hijau di tengah bottom nav.
  Widget _scanButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.pushNamed(context, '/citrus-scan'),
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

  /// Snackbar sederhana untuk fitur yang belum tersedia.
  void _showComingSoon(String fitur) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$fitur segera hadir'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
