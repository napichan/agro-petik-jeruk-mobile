import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Kartu hijau berisi tips singkat dari mandor kebun.
class TipsCard extends StatelessWidget {
  const TipsCard({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final separator = text.indexOf(': ');
    final title = separator >= 0 ? text.substring(0, separator + 1) : '';
    final body = separator >= 0 ? text.substring(separator + 2) : text;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.chatTipsPadding),
        decoration: BoxDecoration(
          color: kLightGreen,
          borderRadius: BorderRadius.circular(AppSizes.chatTipsRadius),
          border: Border.all(color: kChatTipsBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.lightbulb_outline_rounded,
              size: AppSizes.chatTipsIcon,
              color: kPrimaryGreen,
            ),
            const SizedBox(width: AppSizes.chatTipsGap),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    if (title.isNotEmpty)
                      TextSpan(
                        text: '$title ',
                        style: AppTextStyles.chatTipsStrong,
                      ),
                    TextSpan(text: body),
                  ],
                ),
                style: AppTextStyles.chatTips,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
