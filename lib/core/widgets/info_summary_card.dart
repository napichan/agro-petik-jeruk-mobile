import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_icons.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Kartu krem berisi ringkasan durasi dan tiket masuk.
class InfoSummaryCard extends StatelessWidget {
  const InfoSummaryCard({
    super.key,
    required this.duration,
    required this.price,
  });

  final String duration;
  final String price;

  @override
  Widget build(BuildContext context) {
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
              child: _infoColumn(
                icon: const Icon(
                  Icons.schedule_rounded,
                  size: AppSizes.detailInfoIcon,
                  color: kTextSecondary,
                ),
                label: 'DURASI',
                value: duration,
              ),
            ),
            const VerticalDivider(
              width: 1,
              thickness: 1,
              color: kDetailCreamBorder,
            ),
            Expanded(
              child: _infoColumn(
                icon: SvgPicture.asset(
                  AppIcons.ticket,
                  width: AppSizes.detailInfoIcon,
                  height: AppSizes.detailInfoIcon,
                  colorFilter: const ColorFilter.mode(
                    kTextSecondary,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'TIKET MASUK',
                value: price,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn({
    required Widget icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(height: AppSizes.detailInfoIconGap),
        Text(label, style: AppTextStyles.detailInfoLabel),
        const SizedBox(height: AppSizes.detailInfoLabelGap),
        Text(
          value,
          textAlign: TextAlign.center,
          style: AppTextStyles.detailInfoValue,
        ),
      ],
    );
  }
}
