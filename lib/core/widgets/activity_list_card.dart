import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_icons.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../models/activity_item.dart';

/// Kartu putih berisi daftar aktivitas dengan ikon di lingkaran lembut.
class ActivityListCard extends StatelessWidget {
  const ActivityListCard({
    super.key,
    required this.items,
    this.iconSize = AppSizes.detailActivityIcon,
    this.textStyle,
  });

  final List<ActivityItem> items;

  /// Ukuran kotak/lingkaran ikon. Default mengikuti detail wisata.
  final double iconSize;

  /// Gaya teks baris aktivitas. Default mengikuti detail wisata.
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
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
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSizes.detailActivityRowGap),
            _activityRow(items[i]),
          ],
        ],
      ),
    );
  }

  Widget _activityRow(ActivityItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: iconSize,
          height: iconSize,
          decoration: BoxDecoration(
            color: _toneColor(item.tone),
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.antiAlias,
          child: _icon(item.icon),
        ),
        const SizedBox(width: AppSizes.detailActivityIconGap),
        Expanded(
          child: Text(
            item.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle ?? AppTextStyles.detailActivityText,
          ),
        ),
      ],
    );
  }

  Widget _icon(ActivityIconType icon) {
    final asset = _iconAsset(icon);
    if (asset == null) {
      // Aset SVG keranjang belum tersedia di assets/icons.
      return Icon(
        Icons.shopping_basket_outlined,
        size: iconSize * 0.56,
        color: kActivityIconTeal,
      );
    }

    return SvgPicture.asset(asset, width: iconSize, height: iconSize);
  }

  String? _iconAsset(ActivityIconType icon) {
    return switch (icon) {
      ActivityIconType.check => AppIcons.check,
      ActivityIconType.checkGreen => AppIcons.checkGreen,
      ActivityIconType.scissors => AppIcons.scissors,
      ActivityIconType.pruning => AppIcons.pruning,
      ActivityIconType.mountain => AppIcons.mountain,
      ActivityIconType.guide => AppIcons.guide,
      ActivityIconType.recycle => AppIcons.recycle,
      ActivityIconType.pest => AppIcons.pest,
      ActivityIconType.basket => null,
      ActivityIconType.book => AppIcons.book,
      ActivityIconType.document => AppIcons.document,
      ActivityIconType.observation => AppIcons.observation,
      ActivityIconType.data => AppIcons.data,
      ActivityIconType.farmer => AppIcons.farmer,
    };
  }

  Color _toneColor(ActivityTone tone) {
    return switch (tone) {
      ActivityTone.green => kActivityToneGreen,
      ActivityTone.salmon => kActivityToneSalmon,
      ActivityTone.blue => kActivityToneBlue,
      ActivityTone.lime => kActivityToneLime,
      ActivityTone.teal => kActivityToneTeal,
      ActivityTone.yellow => kActivityToneYellow,
    };
  }
}
