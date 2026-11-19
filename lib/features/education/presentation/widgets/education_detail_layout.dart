import 'package:flutter/material.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import 'package:flutter_agrowisatajeruk/core/widgets/activity_list_card.dart';
import 'package:flutter_agrowisatajeruk/core/widgets/detail_hero_header.dart';
import 'package:flutter_agrowisatajeruk/core/widgets/facility_grid.dart';
import 'package:flutter_agrowisatajeruk/core/widgets/info_summary_card.dart';

import '../../domain/entities/education_activity.dart';

/// Layout detail aktivitas edukasi (edukasi, wawancara, penelitian).
///
/// Memakai ulang widget yang sama dengan detail wisata, dengan ukuran
/// lingkaran ikon aktivitas yang lebih kecil sesuai desain Figma.
class EducationDetailLayout extends StatelessWidget {
  const EducationDetailLayout({
    super.key,
    required this.data,
    required this.priceFormatted,
    required this.activitySectionTitle,
  });

  final EducationActivity data;
  final String priceFormatted;
  final String activitySectionTitle;

  @override
  Widget build(BuildContext context) {
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
              image: data.heroImage,
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
                    Text(data.title, style: AppTextStyles.detailTitle),
                    const SizedBox(height: AppSizes.detailTitleGap),
                    _address(data.address),
                    const SizedBox(height: AppSizes.detailInfoTopGap),
                    InfoSummaryCard(
                      duration: data.duration,
                      price: priceFormatted,
                    ),
                    _sectionTitle(activitySectionTitle),
                    ActivityListCard(
                      items: data.activities,
                      iconSize: AppSizes.educationActivityIcon,
                      textStyle: AppTextStyles.educationActivityText,
                    ),
                    _sectionTitle('Fasilitas'),
                    FacilityGrid(
                      items: data.facilities,
                      horizontalInset: AppSizes.educationFacilityInset,
                    ),
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
}
