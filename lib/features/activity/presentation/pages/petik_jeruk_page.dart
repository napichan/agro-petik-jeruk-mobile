import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../../domain/entities/petik_jeruk_detail.dart';
import '../viewmodels/petik_jeruk_view_model.dart';

/// Gambar hero kebun jeruk Solorejo (lokal).
const String _kKebunAsset = 'assets/images/kebun_jeruk_solorejo.png';

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
            backgroundColor: kSurfaceColor,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildPage(context);
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    // Foto lebih tinggi dari titik sheet agar tetap menutup area di balik
    // sudut sheet; sheet mulai tepat di sekitar 30% tinggi layar.
    final heroHeight =
        MediaQuery.sizeOf(context).height * AppSizes.detailHeroHeightFactor +
        AppSizes.detailSheetOverlap;

    return Scaffold(
      backgroundColor: kSurfaceColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context, heroHeight),
            Transform.translate(
              offset: const Offset(0, -AppSizes.detailSheetOverlap),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  AppSizes.detailHorizontal,
                  AppSizes.detailSheetTopPadding,
                  AppSizes.detailHorizontal,
                  AppSizes.detailSheetBottomPadding,
                ),
                decoration: const BoxDecoration(
                  color: kSurfaceColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSizes.detailSheetRadius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_detail.nama, style: AppTextStyles.detailTitle),
                    const SizedBox(height: AppSizes.detailTitleGap),
                    _address(),
                    const SizedBox(height: AppSizes.detailInfoTopGap),
                    _statistik(),
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
            ),
          ],
        ),
      ),
    );
  }

  // --- HERO: gambar kebun + tombol kembali & chip nama kebun ---
  Widget _buildHero(BuildContext context, double height) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(_kKebunAsset, fit: BoxFit.cover),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSizes.detailHeroHorizontal,
                AppSizes.detailHeroTop,
                AppSizes.detailHeroHorizontal,
                0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _heroButton(
                    key: const ValueKey('petik-kembali'),
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/aktivitas',
                      (route) => route.isFirst,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: AppSizes.detailBackIcon,
                      color: kHeroChipText,
                    ),
                  ),
                  const Spacer(),
                  _chipKebun(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Tombol bundar gelap translusen di atas gambar hero.
  Widget _heroButton({
    Key? key,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Material(
      key: key,
      color: kHeroOverlay,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: AppSizes.detailBackButton,
          height: AppSizes.detailBackButton,
          child: Center(child: child),
        ),
      ),
    );
  }

  /// Chip nama kebun di kanan atas hero.
  Widget _chipKebun() {
    return Container(
      height: AppSizes.detailChipHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.detailChipHorizontal,
      ),
      decoration: BoxDecoration(
        color: kHeroOverlay,
        borderRadius: BorderRadius.circular(AppSizes.radiusChip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.photo_camera_outlined,
            size: AppSizes.detailChipIcon,
            color: kHeroCameraIcon,
          ),
          const SizedBox(width: AppSizes.detailChipGap),
          const Text('Kebun Solorejo', style: AppTextStyles.detailChip),
        ],
      ),
    );
  }

  // --- Alamat di bawah judul ---
  Widget _address() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: AppSizes.detailAddressTop),
          child: Icon(
            Icons.place_outlined,
            size: AppSizes.detailAddressIcon,
            color: kTextMuted,
          ),
        ),
        const SizedBox(width: AppSizes.detailAddressGap),
        Expanded(
          child: Text(
            _detail.alamat,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.detailAddress,
          ),
        ),
      ],
    );
  }

  // --- Kartu krem berisi durasi & tiket masuk ---
  Widget _statistik() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.detailInfoHorizontal,
        vertical: AppSizes.detailInfoVertical,
      ),
      decoration: BoxDecoration(
        color: kDetailCream,
        borderRadius: BorderRadius.circular(AppSizes.detailInfoRadius),
        border: Border.all(color: kDetailCreamBorder),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _statItem(
                icon: const Icon(
                  Icons.schedule_rounded,
                  size: AppSizes.detailInfoIcon,
                  color: kTextSecondary,
                ),
                label: 'DURASI',
                nilai: _detail.durasi,
              ),
            ),
            const VerticalDivider(
              width: 1,
              thickness: 1,
              color: kDetailCreamBorder,
            ),
            Expanded(
              child: _statItem(
                icon: SvgPicture.asset(
                  'assets/icons/ic_ticket.svg',
                  width: AppSizes.detailInfoIcon,
                  height: AppSizes.detailInfoIcon,
                  colorFilter: const ColorFilter.mode(
                    kTextSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'TIKET MASUK',
                nilai: _detail.harga,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem({
    required Widget icon,
    required String label,
    required String nilai,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: AppSizes.detailInfoIconGap),
        Text(label, style: AppTextStyles.detailInfoLabel),
        const SizedBox(height: AppSizes.detailInfoLabelGap),
        Text(
          nilai,
          textAlign: TextAlign.center,
          style: AppTextStyles.detailInfoValue,
        ),
      ],
    );
  }

  // --- Judul section ---
  Widget _sectionTitle(String judul) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSizes.detailSectionGap,
        bottom: AppSizes.detailSectionTitleGap,
      ),
      child: Text(judul, style: AppTextStyles.detailSectionTitle),
    );
  }

  /// Judul section dengan aksi di kanan (mis. chip "Buka Maps").
  Widget _sectionTitleWithAction(String judul, {required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSizes.detailSectionGap,
        bottom: AppSizes.detailSectionTitleGap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(judul, style: AppTextStyles.detailSectionTitle),
          child,
        ],
      ),
    );
  }

  // --- Kartu daftar aktivitas ---
  Widget _kartuAktivitas() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.detailActivityPadding),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        children: [
          for (var i = 0; i < _detail.aktivitas.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSizes.detailActivityRowGap),
            _activityRow(_detail.aktivitas[i]),
          ],
        ],
      ),
    );
  }

  Widget _activityRow(PetikJerukAktivitas item) {
    return Row(
      children: [
        Container(
          width: AppSizes.detailActivityIcon,
          height: AppSizes.detailActivityIcon,
          decoration: BoxDecoration(
            color: item.latar,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: SvgPicture.asset(
            item.ikon,
            width: AppSizes.detailActivityIcon,
            height: AppSizes.detailActivityIcon,
          ),
        ),
        const SizedBox(width: AppSizes.detailActivityIconGap),
        Expanded(
          child: Text(
            item.teks,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.detailActivityText,
          ),
        ),
      ],
    );
  }

  // --- Grid fasilitas (4 kartu) ---
  Widget _fasilitasGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final items = _detail.fasilitas;
        final available =
            (constraints.maxWidth -
                (items.length - 1) * AppSizes.detailFacilityGap) /
            items.length;
        final cardWidth = available < AppSizes.detailFacilityMinWidth
            ? AppSizes.detailFacilityMinWidth
            : available;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const SizedBox(width: AppSizes.detailFacilityGap),
                SizedBox(
                  width: cardWidth,
                  height: AppSizes.detailFacilityHeight,
                  child: _facilityCard(items[i].ikon, items[i].label),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _facilityCard(String ikon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Aset SVG sudah memuat kotak hijau muda (radius 12).
          SvgPicture.asset(
            ikon,
            width: AppSizes.detailFacilityIconBox,
            height: AppSizes.detailFacilityIconBox,
          ),
          const SizedBox(height: AppSizes.detailFacilityLabelGap),
          Text(label, style: AppTextStyles.detailFacilityLabel),
        ],
      ),
    );
  }

  // --- Chip "Buka Maps" ---
  Widget _chipBukaMaps() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: kLightGreen,
        borderRadius: BorderRadius.circular(AppSizes.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.map_outlined, size: 12, color: kPrimaryGreen),
          const SizedBox(width: 4),
          Text(
            'Buka Maps',
            style: AppTextStyles.detailFacilityLabel.copyWith(
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
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: kPrimaryGreen,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Pintu Masuk Utama (Blok A)',
                  style: AppTextStyles.detailFacilityLabel.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
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
              style: AppTextStyles.detailAddress,
            ),
          ),
        ],
      ),
    );
  }

  // --- Judul section ulasan (rating + jumlah ulasan) ---
  Widget _sectionTitleUlasan() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSizes.detailSectionGap,
        bottom: AppSizes.detailSectionTitleGap,
      ),
      child: Row(
        children: [
          Text('Ulasan Pengunjung', style: AppTextStyles.detailSectionTitle),
          const SizedBox(width: 8),
          const Icon(Icons.star_rounded, size: 16, color: kReviewStar),
          const SizedBox(width: 3),
          Text(
            _detail.rating,
            style: AppTextStyles.detailInfoValue.copyWith(fontSize: 13),
          ),
          const Spacer(),
          Text(
            '${_detail.jumlahUlasan} ulasan',
            style: AppTextStyles.detailAddress.copyWith(fontSize: 11),
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
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: kBorderColor),
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
                decoration: const BoxDecoration(
                  color: kPrimaryOrange,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'RN',
                  style: AppTextStyles.detailFacilityLabel.copyWith(
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
                            style: AppTextStyles.detailFacilityLabel.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
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
                            color: kLightGreen,
                            borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                          ),
                          child: Text(
                            'Terverifikasi',
                            style: AppTextStyles.detailFacilityLabel.copyWith(
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
                      style: AppTextStyles.detailAddress.copyWith(
                        fontSize: 10,
                        color: kTextMuted,
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
                  (_) => const Icon(
                    Icons.star_rounded,
                    size: 12,
                    color: kReviewStar,
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
            style: AppTextStyles.detailAddress.copyWith(
              fontSize: 11,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
