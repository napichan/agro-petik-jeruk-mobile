import 'package:flutter/material.dart';

import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import 'package:flutter_agrowisatajeruk/core/widgets/activity_list_card.dart';
import 'package:flutter_agrowisatajeruk/core/widgets/detail_hero_header.dart';
import 'package:flutter_agrowisatajeruk/core/widgets/facility_grid.dart';
import 'package:flutter_agrowisatajeruk/core/widgets/info_summary_card.dart';

import '../../domain/entities/activity_detail.dart';
import '../viewmodels/detail_wisata_viewmodel.dart';

/// Halaman detail wisata "Petik Jeruk Langsung" — full screen tanpa bottom nav.
class DetailWisataPage extends StatefulWidget {
  const DetailWisataPage({super.key, this.activityId = 'petik-jeruk-langsung'});

  final String activityId;

  @override
  State<DetailWisataPage> createState() => _DetailWisataPageState();
}

class _DetailWisataPageState extends State<DetailWisataPage> {
  late final DetailWisataViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createDetailWisataViewModel()
      ..load(widget.activityId);
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
      builder: (context, _) {
        final detail = _viewModel.detail;
        if (detail != null) return _buildPage(context, detail);

        return Scaffold(
          backgroundColor: kSurfaceColor,
          body: _viewModel.errorMessage != null
              ? _buildError(_viewModel.errorMessage!)
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context, ActivityDetail detail) {
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
            DetailHeroHeader(
              image: detail.heroImage,
              height: heroHeight,
              onBack: () => Navigator.maybePop(context),
            ),
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
                    Text(detail.title, style: AppTextStyles.detailTitle),
                    const SizedBox(height: AppSizes.detailTitleGap),
                    _address(detail.address),
                    const SizedBox(height: AppSizes.detailInfoTopGap),
                    InfoSummaryCard(
                      duration: detail.duration,
                      price: _viewModel.hargaFormatted,
                    ),
                    _sectionTitle('Aktivitas'),
                    ActivityListCard(items: detail.activities),
                    _sectionTitle('Fasilitas'),
                    FacilityGrid(items: detail.facilities),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _address(String address) {
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
            address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.detailAddress,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSizes.detailSectionGap,
        bottom: AppSizes.detailSectionTitleGap,
      ),
      child: Text(title, style: AppTextStyles.detailSectionTitle),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.detailErrorPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: AppSizes.detailErrorIcon,
              color: kDangerColor,
            ),
            const SizedBox(height: AppSizes.detailErrorGap),
            Text('Terjadi Kesalahan', style: AppTextStyles.detailErrorTitle),
            const SizedBox(height: AppSizes.detailErrorGap),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.detailErrorMessage,
            ),
            const SizedBox(height: AppSizes.detailErrorActionGap),
            SizedBox(
              height: AppSizes.detailErrorButtonHeight,
              child: Material(
                color: kPrimaryGreen,
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  onTap: () => _viewModel.load(widget.activityId),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.detailSectionGap,
                    ),
                    child: Center(
                      child: Text(
                        'Coba Lagi',
                        style: AppTextStyles.detailRetryButton,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
