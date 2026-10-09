import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'beranda_page.dart';

/// Gambar hero kebun jeruk (lokal).
const String kHeroAsset = 'assets/images/splash_orchard.png';

/// Data lengkap satu aktivitas untuk halaman detail.
class DetailAktivitasData {
  const DetailAktivitasData({
    required this.nama,
    required this.alamat,
    required this.durasi,
    required this.harga,
    required this.rating,
    required this.jumlahUlasan,
    required this.aktivitas,
    required this.fasilitas,
    required this.titikKumpulJudul,
    required this.titikKumpulAlamat,
    required this.reviewer,
    required this.reviewTeks,
  });

  final String nama;
  final String alamat;
  final String durasi;
  final int harga;
  final String rating;
  final String jumlahUlasan;
  final List<({IconData ikon, String teks})> aktivitas;
  final List<({IconData ikon, String label})> fasilitas;
  final String titikKumpulJudul;
  final String titikKumpulAlamat;
  final String reviewer;
  final String reviewTeks;
}

/// Template halaman detail aktivitas — dipakai bersama oleh
/// EdukasiPage, WawancaraPage, dan PenelitianPage.
/// (PetikJerukPage memakai layout desainnya sendiri di petik_jeruk_page.dart.)
class DetailAktivitasTemplate extends StatelessWidget {
  const DetailAktivitasTemplate({super.key, required this.data});

  final DetailAktivitasData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context),
            _buildKonten(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  // --- HERO GAMBAR + TOMBOL KEMBALI + CHIP ---
  Widget _buildHero(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 210,
          width: double.infinity,
          child: Image.asset(kHeroAsset, fit: BoxFit.cover),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol kembali (lingkaran putih translusen).
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Chip nama kebun.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Kebun Solorejo',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- KONTEN UTAMA (sheet putih menimpa hero) ---
  Widget _buildKonten(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul + alamat.
            Text(
              data.nama,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.place, size: 14, color: kPrimaryGreen),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    data.alamat,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      height: 1.5,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // 3 kotak statistik.
            Row(
              children: [
                _statBox('Durasi', data.durasi, null),
                const SizedBox(width: 10),
                _statBox('Tiket Masuk', _rupiah(data.harga), null),
                const SizedBox(width: 10),
                _statBox('Ulasan', data.rating, data.jumlahUlasan),
              ],
            ),
            _sectionTitle('Aktivitas'),
            _buildDaftarAktivitas(),
            _sectionTitle('Fasilitas'),
            _buildFasilitas(),
            _sectionTitle('Tik Kumpul'),
            _buildTikKumpul(),
            _sectionTitle('Ulasan Pengunjung'),
            _buildUlasan(),
          ],
        ),
      ),
    );
  }

  // --- Kotak statistik (durasi / tiket / ulasan) ---
  Widget _statBox(String label, String nilai, String? keterangan) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              nilai,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (keterangan != null) ...[
              const SizedBox(height: 2),
              Text(
                keterangan,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // --- Judul section ---
  Widget _sectionTitle(String judul) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        judul,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // --- Daftar aktivitas (ikon hijau + teks) ---
  Widget _buildDaftarAktivitas() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(data.aktivitas.length, (i) {
          final item = data.aktivitas[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: kPrimaryGreen.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.ikon, size: 16, color: kPrimaryGreen),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.teks,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- Fasilitas (4 tile ikon) ---
  Widget _buildFasilitas() {
    return Row(
      children: List.generate(data.fasilitas.length, (i) {
        final item = data.fasilitas[i];
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < data.fasilitas.length - 1 ? 10 : 0),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Icon(item.ikon, size: 20, color: kPrimaryGreen),
                const SizedBox(height: 6),
                Text(
                  item.label,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // --- Kartu titik kumpul ---
  Widget _buildTikKumpul() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
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
                    const Icon(Icons.flag, size: 14, color: kPrimaryGreen),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        data.titikKumpulJudul,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.place, size: 12, color: Colors.grey.shade500),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        data.titikKumpulAlamat,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          height: 1.4,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Chip status tiket.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: kPrimaryGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: kPrimaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Buka Tiket',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Ringkasan + kartu ulasan ---
  Widget _buildUlasan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(width: 6),
            Text(
              data.rating,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: kPrimaryGreen,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '${data.jumlahUlasan} ulasan',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar inisial.
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: kPrimaryOrange.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      data.reviewer[0],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryOrange,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data.reviewer,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Chip Verified.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryGreen.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Verified',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryGreen,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Bintang.
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      5,
                      (i) => const Icon(
                        Icons.star,
                        size: 12,
                        color: Color(0xFFFBBF24),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                data.reviewTeks,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  height: 1.6,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- BOTTOM BAR: harga + tombol pesan ---
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MULAI DARI',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: _rupiah(data.harga),
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: ' /orang',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                // Lanjut ke alur pemesanan tiket.
                onPressed: () => Navigator.pushNamed(context, '/pesan-tiket'),
                child: Text(
                  'Pesan Sekarang',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
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
}
