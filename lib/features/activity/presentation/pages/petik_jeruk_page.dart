import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../domain/entities/petik_jeruk_detail.dart';
import '../viewmodels/petik_jeruk_view_model.dart';

/// Gambar hero kebun jeruk Solorejo (lokal).
const String _kKebunAsset = 'assets/images/Kebun Jeruk Solorejo.png';

/// Halaman detail "Petik Jeruk Langsung" — sesuai desain UI.
class PetikJerukPage extends StatefulWidget {
  const PetikJerukPage({super.key});

  @override
  State<PetikJerukPage> createState() => _PetikJerukPageState();
}

class _PetikJerukPageState extends State<PetikJerukPage> {
  late final PetikJerukViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createPetikJerukViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  PetikJerukDetail get _detail => _viewModel.detail!;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        if (_viewModel.detail == null) {
          return const Scaffold(
            backgroundColor: kBgColor,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildPage(context);
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHero(context),
            _buildKonten(),
          ],
        ),
      ),
    );
  }

  // --- HERO: gambar kebun + tombol kembali, chip lokasi & profil ---
  Widget _buildHero(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 230,
          width: double.infinity,
          child: Image.asset(_kKebunAsset, fit: BoxFit.cover),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  // Tombol kembali -> halaman Aktivitas.
                  _heroButton(
                    key: const ValueKey('petik-kembali'),
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/aktivitas',
                      (route) => route.isFirst,
                    ),
                    child: const Iconify(
                      Mdi.chevron_left,
                      size: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
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
                        const Iconify(
                          Mdi.storefront_outline,
                          size: 12,
                          color: Colors.white,
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
                  const SizedBox(width: 8),
                  // Tombol profil -> halaman Profile.
                  _heroButton(
                    key: const ValueKey('petik-profil'),
                    onTap: () => Navigator.pushNamed(context, '/profile'),
                    child: const Iconify(
                      Mdi.account_outline,
                      size: 20,
                      color: Colors.black87,
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

  /// Tombol bundar putih translusen di atas gambar hero.
  Widget _heroButton({
    Key? key,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return InkWell(
      key: key,
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }

  // --- KONTEN: sheet putih (judul, alamat, statistik) + section bawah ---
  Widget _buildKonten() {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sheet putih menimpa gambar hero.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _detail.nama,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Iconify(
                      Mdi.map_marker_outline,
                      size: 15,
                      color: kPrimaryGreen,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _detail.alamat,
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
                _statistik(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle('Aktivitas'),
                _kartuAktivitas(),
                _sectionTitle('Fasilitas'),
                _fasilitasGrid(),
                _sectionTitleWithAction(
                  'Titik Kumpul',
                  child: _chipBukaMaps(),
                ),
                _kartuTitikKumpul(),
                _sectionTitleUlasan(),
                _kartuUlasan(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 3 kotak statistik dalam satu kartu berbingkai ---
  Widget _statistik() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _statItem(Mdi.clock_outline, 'DURASI', _detail.durasi),
            ),
            _dividerStatistik(),
            Expanded(
              child: _statItem(Mdi.ticket_outline, 'TIKET MASUK', _detail.harga),
            ),
            _dividerStatistik(),
            Expanded(
              child: _statItem(
                Mdi.star,
                'ULASAN',
                '${_detail.rating} (${_detail.jumlahUlasan})',
                warnaIkon: const Color(0xFFFBBF24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(
    String ikon,
    String label,
    String nilai, {
    Color warnaIkon = kPrimaryGreen,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Iconify(ikon, size: 13, color: warnaIkon),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            nilai,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerStatistik() =>
      Container(width: 1, color: Colors.grey.shade200);

  // --- Judul section ---
  Widget _sectionTitle(String judul) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        judul,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Judul section dengan aksi di kanan (mis. chip "Buka Maps").
  Widget _sectionTitleWithAction(String judul, {required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            judul,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          child,
        ],
      ),
    );
  }

  // --- Kartu daftar aktivitas ---
  Widget _kartuAktivitas() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: List.generate(_detail.aktivitas.length, (i) {
          final item = _detail.aktivitas[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: item.latar,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Iconify(item.ikon, size: 16, color: item.warnaIkon),
                  ),
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

  // --- Grid fasilitas (4 tile ikon) ---
  Widget _fasilitasGrid() {
    return Row(
      children: List.generate(_detail.fasilitas.length, (i) {
        final item = _detail.fasilitas[i];
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: i < _detail.fasilitas.length - 1 ? 10 : 0,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Iconify(item.ikon, size: 20, color: kPrimaryGreen),
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

  // --- Chip "Buka Maps" ---
  Widget _chipBukaMaps() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: kPrimaryGreen.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Iconify(Mdi.map_outline, size: 12, color: kPrimaryGreen),
          const SizedBox(width: 4),
          Text(
            'Buka Maps',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: kPrimaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  // --- Kartu titik kumpul ---
  Widget _kartuTitikKumpul() {
    return Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Iconify(
                Mdi.map_marker_radius_outline,
                size: 18,
                color: kPrimaryGreen,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Pintu Masuk Utama (Blok A)',
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
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'Agro Wisata Petik Jeruk, Desa Solorejo, Kec. Dau, Kab. Malang',
              style: GoogleFonts.inter(
                fontSize: 11,
                height: 1.4,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Judul section ulasan (rating + jumlah ulasan) ---
  Widget _sectionTitleUlasan() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Text(
            'Ulasan Pengunjung',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          const Iconify(Mdi.star, size: 14, color: Color(0xFFFBBF24)),
          const SizedBox(width: 3),
          Text(
            '4.9',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            '${_detail.jumlahUlasan} ulasan',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // --- Kartu ulasan pengunjung ---
  Widget _kartuUlasan() {
    return Container(
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
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kPrimaryOrange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'RN',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Rina Kusumawardani',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
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
                            'Terverifikasi',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '2 hari yang lalu',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Rating bintang.
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (_) => const Iconify(
                    Mdi.star,
                    size: 12,
                    color: Color(0xFFFBBF24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '"Jeruknya manis segar, banyak pilihan lebat, dan pemandangan '
            'lereng Dau indah banget buat liburan keluarga! Gunting & '
            'keranjang sangat bagus."',
            style: GoogleFonts.inter(
              fontSize: 11,
              height: 1.6,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}


