import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../../domain/entities/chat_recommendation.dart';

/// Kartu rekomendasi jeruk lengkap dengan aksi peta dan pesan tiket.
class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    super.key,
    required this.recommendation,
    required this.onMapTap,
    required this.onOrderTap,
  });

  final ChatRecommendation recommendation;
  final VoidCallback onMapTap;
  final VoidCallback onOrderTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.chatCardPadding),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(AppSizes.chatCardRadius),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _tagChip(
                label: recommendation.sector,
                background: kLightOrange,
                textStyle: AppTextStyles.chatCardSector,
              ),
              const Spacer(),
              _tagChip(
                label: recommendation.grade,
                background: kLightGreen,
                textStyle: AppTextStyles.chatCardGrade,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.chatCardRowGap),
          Row(
            children: [
              Container(
                width: AppSizes.chatCardThumb,
                height: AppSizes.chatCardThumb,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kChatRecommendationThumb,
                  borderRadius: BorderRadius.circular(
                    AppSizes.chatCardThumbRadius,
                  ),
                ),
                child: Text(
                  recommendation.emoji,
                  style: const TextStyle(
                    fontSize: AppSizes.chatCardThumbIcon,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.chatCardThumbGap),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendation.name,
                      style: AppTextStyles.chatCardName,
                    ),
                    const SizedBox(height: AppSizes.chatCardPriceGap),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          recommendation.priceLabel,
                          style: AppTextStyles.chatCardPrice,
                        ),
                        Text(' / kg', style: AppTextStyles.chatCardUnit),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.chatCardRowGap),
          Wrap(
            spacing: AppSizes.chatCardChipGap,
            runSpacing: AppSizes.chatCardChipGap,
            children: [
              _infoChip(
                dotColor: kPrimaryOrange,
                label: recommendation.brixLabel,
                background: kSurfaceColor,
                borderColor: kBorderColor,
                textColor: kTextSecondary,
              ),
              _infoChip(
                dotColor: kPrimaryGreen,
                label: recommendation.readyLabel,
                background: kLightGreen,
                textColor: kPrimaryGreen,
              ),
            ],
          ),
          const SizedBox(height: AppSizes.chatCardBodyGap),
          Text(
            recommendation.description,
            style: AppTextStyles.chatCardBody,
          ),
          const SizedBox(height: AppSizes.chatCardActionsGap),
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  label: 'Peta Kebun',
                  icon: Icons.map_outlined,
                  background: kChatMapButton,
                  foreground: kChatMapButtonText,
                  style: AppTextStyles.chatCardButton,
                  onTap: onMapTap,
                ),
              ),
              const SizedBox(width: AppSizes.chatCardActionGap),
              Expanded(
                child: _actionButton(
                  label: 'Pesan Tiket',
                  icon: Icons.confirmation_number_outlined,
                  background: kPrimaryGreen,
                  foreground: Colors.white,
                  style: AppTextStyles.chatCardButtonGreen,
                  onTap: onOrderTap,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tagChip({
    required String label,
    required Color background,
    required TextStyle textStyle,
  }) {
    return Container(
      height: AppSizes.chatTagHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.chatTagHorizontal,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSizes.chatTagRadius),
      ),
      child: Text(label, style: textStyle),
    );
  }

  Widget _infoChip({
    required Color dotColor,
    required String label,
    required Color background,
    Color? borderColor,
    required Color textColor,
  }) {
    return Container(
      height: AppSizes.chatCardChipHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.chatTagHorizontal,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppSizes.chatCardChipRadius),
        border: borderColor == null ? null : Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizes.chatCardChipDot,
            height: AppSizes.chatCardChipDot,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSizes.chatChipDotGap),
          Text(
            label,
            style: AppTextStyles.chatCardChip.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required Color background,
    required Color foreground,
    required TextStyle style,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.chatCardActionRadius),
      child: Container(
        height: AppSizes.chatCardActionHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppSizes.chatCardActionRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppSizes.chatCardActionIcon, color: foreground),
            const SizedBox(width: AppSizes.chatChipDotGap),
            Text(label, style: style),
          ],
        ),
      ),
    );
  }
}
