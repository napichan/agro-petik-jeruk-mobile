
import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';
import 'package:flutter_agrowisatajeruk/shared/widgets/app_bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';

import '../../domain/entities/popular_activity.dart';
import '../viewmodels/home_view_model.dart';

/// Gambar hero section Beranda.
const String _kHeroAsset = 'assets/images/hero.png';

/// Halaman beranda — sesuai desain UI "Beranda".
class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createHomeViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      // Custom Bottom Navigation Bar dengan tombol Citrus Scan di tengah.
      bottomNavigationBar: const AppBottomNav(activeIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.screenHorizontal,
            AppSizes.screenTop,
            AppSizes.screenHorizontal,
            AppSizes.scrollBottomPadding,
          ),
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
              const SizedBox(height: AppSizes.sectionGap),
              _buildInformasiPenting(),
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
          children: [
            // Chip lokasi hijau muda.
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: kLightGreen,
                    borderRadius: BorderRadius.circular(AppSizes.radiusChip),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: AppSizes.locationDot,
                        height: AppSizes.locationDot,
                        decoration: const BoxDecoration(
                          color: kPrimaryGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'WISATA ALAM SOLOREJO, MALANG',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.locationChip,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Tombol Notifikasi -> halaman Notifikasi.
            InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.pushNamed(context, '/notifikasi'),
              child: Container(
                width: AppSizes.headerButton,
                height: AppSizes.headerButton,
                decoration: BoxDecoration(
                  color: kSurfaceColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Iconify(
                    Mdi.bell_outline,
                    color: kPrimaryOrange,
                    size: AppSizes.headerIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Halo ${_viewModel.content?.userFirstName ?? 'Budi'}',
          style: AppTextStyles.greeting,
        ),
        const SizedBox(height: 2),
        Text('Ayo! Jelajahi aktivitas', style: AppTextStyles.subGreeting),
      ],
    );
  }

  // --- WIDGET HERO BANNER (foto hero + gradasi terang + tombol Pesan Tiket) ---
  Widget _buildHeroBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: SizedBox(
        height: 196,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _kHeroAsset,
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heroBadge(),
                  const Spacer(),
                  SizedBox(
                    width: 218,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Petik Jeruk, Ciptakan\nMomen Seru!',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            height: 1.18,
                            color: kTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rasakan pengalaman memetik jeruk langsung '
                          'dari pohonnya bersama keluarga.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            height: 1.45,
                            color: kTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _heroPesanTiketButton(),
                      ],
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

  Widget _heroBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(AppSizes.radiusChip),
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
          const SizedBox(width: 5),
          Text(
            'AGRO WISATA PETIK JERUK, SOLOREJO',
            style: GoogleFonts.inter(
              fontSize: 7.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
              color: kPrimaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroPesanTiketButton() {
    return Material(
      color: kPrimaryOrange,
      borderRadius: BorderRadius.circular(AppSizes.radiusChip),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusChip),
        onTap: () => Navigator.pushNamed(context, '/pesan-tiket'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pesan Tiket',
                style: GoogleFonts.inter(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 13,
                color: Colors.white,
              ),
            ],
          ),
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
          children: [
            Expanded(
              child: Text(
                'Jelajahi Sekarang',
                style: AppTextStyles.sectionTitle,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: kLightOrange,
                borderRadius: BorderRadius.circular(AppSizes.radiusChip),
              ),
              child: Text('Fitur Utama', style: AppTextStyles.featureChip),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _menuItem(
                iconData: Mdi.ticket_confirmation_outline,
                title: 'Pesan Tiket',
                iconColor: kPrimaryOrange,
                iconBackground: kLightOrange,
                // Pesan Tiket -> alur pemesanan tiket.
                onTap: () => Navigator.pushNamed(context, '/pesan-tiket'),
              ),
            ),
            const SizedBox(width: AppSizes.menuCardGap),
            Expanded(
              child: _menuItem(
                iconData: Mdi.map_search_outline,
                title: 'Jelajahi Aktivitas',
                iconColor: kPrimaryGreen,
                iconBackground: kLightGreen,
                // Jelajahi Aktivitas -> halaman daftar aktivitas.
                onTap: () => Navigator.pushNamed(context, '/aktivitas'),
              ),
            ),
            const SizedBox(width: AppSizes.menuCardGap),
            Expanded(
              child: _menuItem(
                iconData: Mdi.message_processing_outline,
                title: 'ChatBot AI',
                iconColor: kPrimaryOrange,
                iconBackground: kLightOrange,
                onTap: () => Navigator.pushNamed(context, '/chatbot'),
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
    required Color iconBackground,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      onTap: onTap,
      child: Container(
        height: AppSizes.menuCardHeight,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          border: Border.all(color: kBorderColor),
        ),
        child: Column(
          children: [
            Container(
              width: AppSizes.menuIconBox,
              height: AppSizes.menuIconBox,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              ),
              child: Center(
                child: Iconify(
                  iconData,
                  color: iconColor,
                  size: AppSizes.menuIcon,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Tinggi label tetap agar semua label sejajar walau 1-2 baris.
            SizedBox(
              height: AppSizes.menuLabelHeight,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.menuLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET AKTIVITAS POPULER (kartu gambar + harga + Pesan) ---
  List<PopularActivity> get activities =>
      _viewModel.content?.activities ?? const [];

  Widget _buildAktivitasPopuler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Aktivitas Populer', style: AppTextStyles.sectionTitleGreen),
        const SizedBox(height: 2),
        Text(
          'Pilihan favorit pengunjung minggu ini',
          style: AppTextStyles.sectionSubtitle,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: activities.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, i) => _aktivitasCard(activities[i]),
          ),
        ),
      ],
    );
  }

  /// Kartu aktivitas: gambar kebun dengan chip Populer + label,
  /// lalu judul, deskripsi, dan baris harga + tombol Pesan.
  Widget _aktivitasCard(PopularActivity item) {
    // Petik Jeruk Langsung → halaman Petik Jeruk,
    // Edukasi Wisata → halaman daftar edukasi.
    final route = switch (item.nama) {
      'Petik Jeruk Langsung' => '/petik-jeruk',
      'Edukasi Wisata' => '/edukasi',
      _ => null,
    };
    return GestureDetector(
      onTap: route == null ? null : () => Navigator.pushNamed(context, route),
      child: _aktivitasCardBody(item),
    );
  }

  Widget _aktivitasCardBody(PopularActivity item) {
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
          // Gambar dengan chip Populer di atasnya.
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(image: AssetImage(item.image), fit: BoxFit.cover),
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

  // --- INFORMASI PENTING ---
  Widget _buildInformasiPenting() {
    return InkWell(
      borderRadius: BorderRadius.circular(AppSizes.infoCardRadius),
      onTap: () => Navigator.pushNamed(context, '/informasi'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(AppSizes.infoCardRadius),
          border: Border.all(color: kBorderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Informasi Penting', style: AppTextStyles.cardTitle),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Chip jam operasional.
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: kLightOrange,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusChip,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 10,
                              color: kPrimaryOrange,
                            ),
                            const SizedBox(width: 4),
                            Text('08.00-16.00', style: AppTextStyles.clockChip),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Cek tata tertib & syarat kunjungan sebelum datang',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.caption,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, size: 18, color: kTextMuted),
          ],
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
