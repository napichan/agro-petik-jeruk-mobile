import 'package:flutter/material.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Foto hero penuh di belakang status bar, dengan tombol kembali bulat
/// dan chip nama kebun.
class DetailHeroHeader extends StatelessWidget {
  const DetailHeroHeader({
    super.key,
    required this.image,
    required this.height,
    required this.onBack,
  });

  final String image;
  final double height;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(image, fit: BoxFit.cover),
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
                children: [_backButton(), const Spacer(), _kebunChip()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton() {
    return Material(
      color: kHeroOverlay,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onBack,
        child: const SizedBox(
          width: AppSizes.detailBackButton,
          height: AppSizes.detailBackButton,
          child: Icon(
            Icons.arrow_back_rounded,
            size: AppSizes.detailBackIcon,
            color: kHeroChipText,
          ),
        ),
      ),
    );
  }

  Widget _kebunChip() {
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
          Text('Kebun Solorejo', style: AppTextStyles.detailChip),
        ],
      ),
    );
  }
}
