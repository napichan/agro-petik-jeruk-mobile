import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../../domain/entities/quick_reply.dart';

/// Chip saran pertanyaan di bawah pesan pembuka bot.
class QuickReplyChips extends StatelessWidget {
  const QuickReplyChips({
    super.key,
    required this.replies,
    required this.onTap,
  });

  final List<QuickReply> replies;
  final ValueChanged<QuickReply> onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final reply in replies)
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.chatSuggestChipGap),
            child: _chip(reply),
          ),
      ],
    );
  }

  Widget _chip(QuickReply reply) {
    return InkWell(
      onTap: () => onTap(reply),
      borderRadius: BorderRadius.circular(AppSizes.radiusPill),
      child: Container(
        height: AppSizes.chatSuggestChipHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.chatSuggestHorizontal,
        ),
        decoration: BoxDecoration(
          color: kSurfaceColor,
          borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          border: Border.all(color: kBorderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _icon(reply.icon),
            const SizedBox(width: AppSizes.chatInputIconGap),
            Text(reply.label, style: AppTextStyles.chatSuggest),
          ],
        ),
      ),
    );
  }

  Widget _icon(QuickReplyIcon icon) {
    return switch (icon) {
      QuickReplyIcon.orange => const Icon(
        Icons.circle,
        size: AppSizes.chatCardChipDot * 2,
        color: kPrimaryOrange,
      ),
      QuickReplyIcon.sun => const Icon(
        Icons.wb_sunny_outlined,
        size: AppSizes.chatSuggestIcon,
        color: kPrimaryOrange,
      ),
      QuickReplyIcon.none => const SizedBox.shrink(),
    };
  }
}
