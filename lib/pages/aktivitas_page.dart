import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'beranda_page.dart';

/// Warna kategori biru untuk badge "Workshop".
const Color _kBlue = Color(0xFF2563EB);

/// Item aktivitas pada daftar halaman Aktivitas.
class _AktivitasItem {
  const _AktivitasItem({
    required this.nama,
    required this.badge,
    required this.badgeHijau,
    required this.chip,
    required this.chipHijau,
    required this.chipBintang,
    required this.rating,
    required this.harga,
    required this.ruteDetail,
  });

  final String nama;
  final String badge;
  final bool badgeHijau;
  final String chip;
  final bool chipHijau;
  final bool chipBintang;
  final String rating;
  final int harga;
  final String ruteDetail;
}

/// Daftar aktivitas sesuai desain UI "Jelajahi Aktivitas".
const List<_AktivitasItem> _daftarAktivitas = [
  _AktivitasItem(
    nama: 'Petik Jeruk Langsung',
    badge: 'Fasilit.',
    badgeHijau: true,
    chip: 'Makan Sepuasnya',
    chipHijau: true,
    chipBintang: true,
    rating: '4.7',
    harga: 25000,
    ruteDetail: '/petik-jeruk',
  ),
  _AktivitasItem(
    nama: 'Edukasi Budidaya Tani',
    badge: 'Workshop',
    badgeHijau: false,
    chip: 'Kelarga & Pelajar',
    chipHijau: false,
    chipBintang: false,
    rating: '4.9',
    harga: 35000,
    ruteDetail: '/edukasi',
  ),
  _AktivitasItem(
    nama: 'Wawancara',
    badge: 'Workshop',
    badgeHijau: false,
    chip: 'Kelarga & Pelajar',
    chipHijau: false,
    chipBintang: false,
    rating: '4.9',
    harga: 50000,
    ruteDetail: '/wawancara',
  ),
  _AktivitasItem(
    nama: 'Penelitian',
    badge: 'Fasilit.',
    badgeHijau: true,
    chip: 'Makan Sepuasnya',
    chipHijau: true,
    chipBintang: true,
    rating: '4.9',
    harga: 25000,
    ruteDetail: '/penelitian',
  ),
];

/// Halaman Aktivitas — daftar semua aktivitas kebun jeruk Solorejo.
class AktivitasPage extends StatelessWidget {
  const AktivitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      bottomNavigationBar: _buildFooter(context),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                itemCount: _daftarAktivitas.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, i) => _kartu(context, _daftarAktivitas[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HEADER (kembali, judul, ikon akun) ---
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 20, 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black87,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Aktivitas',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kPrimaryOrange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Iconify(
                Mdi.account_outline,
                color: kPrimaryOrange,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU AKTIVITAS ---
  Widget _kartu(BuildContext context, _AktivitasItem item) {
    final warnaBadge = item.badgeHijau ? kPrimaryGreen : _kBlue;
    final warnaChip = item.chipHijau ? kPrimaryGreen : _kBlue;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      // Detail -> halaman detail sesuai aktivitas.
      onTap: () => Navigator.pushNamed(context, item.ruteDetail),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris 1: badge kategori + chip khalayak + rating.
            Row(
              children: [
                _chip(item.badge, warnaBadge),
                const SizedBox(width: 6),
                _chip(item.chip, warnaChip, bintang: item.chipBintang),
                const Spacer(),
                Text(
                  item.rating,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Baris 2: nama, harga, dan tautan Detail.
            Row(
              children: [
                Expanded(
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
                      Text.rich(
                        TextSpan(
                          text: _rupiah(item.harga),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryOrange,
                          ),
                          children: [
                            TextSpan(
                              text: ' /org',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Tautan Detail >.
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Detail',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Chip kategori berwarna tint.
  Widget _chip(String label, Color warna, {bool bintang = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (bintang) ...[
            Icon(Icons.star, size: 10, color: warna),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: warna,
            ),
          ),
        ],
      ),
    );
  }

  // --- FOOTER HIJAU (info kebun + Info Tiket) ---
  Widget _buildFooter(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: kPrimaryGreen,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '• Kebun Salak Hilir Inti • Casia Cemil di Dau',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              // Info Tiket -> alur pemesanan tiket.
              onTap: () => Navigator.pushNamed(context, '/pesan-tiket'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Info Tiket',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
