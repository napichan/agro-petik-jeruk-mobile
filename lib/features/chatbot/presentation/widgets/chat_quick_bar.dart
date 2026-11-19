import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../../domain/entities/quick_reply.dart';

/// Deretan chip saran horizontal tepat di atas kolom input.
class ChatQuickBar extends StatelessWidget {
  const ChatQuickBar({
    super.key,
    required this.replies,
    required this.onTap,
  });

  final List<QuickReply> replies;
  final ValueChanged<QuickReply> onTap;

  @override
  Widget build(BuildContext context) {
    if (replies.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: AppSizes.chatQuickBarHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.chatPageHorizontal,
        ),
        itemCount: replies.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: AppSizes.chatQuickBarGap),
        itemBuilder: (context, index) {
          final reply = replies[index];
          return InkWell(
            onTap: () => onTap(reply),
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.chatQuickChipHorizontal,
              ),
              decoration: BoxDecoration(
                color: kChipGrey,
                borderRadius: BorderRadius.circular(AppSizes.radiusPill),
              ),
              child: Text(reply.label, style: AppTextStyles.chatSuggest),
            ),
          );
        },
      ),
    );
  }
}
