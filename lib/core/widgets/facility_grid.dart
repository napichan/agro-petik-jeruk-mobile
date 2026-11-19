import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_icons.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../models/facility.dart';

/// Baris horizontal kartu fasilitas; dapat digeser bila lebar kurang.
class FacilityGrid extends StatelessWidget {
  const FacilityGrid({
    super.key,
    required this.items,
    this.horizontalInset = 0,
  });

  final List<Facility> items;

  /// Jarak tambahan kiri-kanan agar baris fasilitas sedikit menjorok ke dalam.
  final double horizontalInset;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalInset),
      child: LayoutBuilder(
        builder: (context, constraints) {
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
                    child: _facilityCard(items[i]),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _facilityCard(Facility item) {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        border: Border.all(color: kBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon(item.icon),
          const SizedBox(height: AppSizes.detailFacilityLabelGap),
          Text(item.label, style: AppTextStyles.detailFacilityLabel),
        ],
      ),
    );
  }

  /// Ikon berasal dari aset SVG yang sudah memuat kotak hijau muda
  /// (radius 12), jadi tidak diberi latar tambahan di sini.
  Widget _icon(FacilityIconType icon) {
    final asset = switch (icon) {
      FacilityIconType.parking => AppIcons.car,
      FacilityIconType.toilet => AppIcons.toilet,
      FacilityIconType.hut => AppIcons.hut,
      FacilityIconType.store => AppIcons.store,
    };

    return SvgPicture.asset(
      asset,
      width: AppSizes.detailFacilityIconBox,
      height: AppSizes.detailFacilityIconBox,
    );
  }
}
