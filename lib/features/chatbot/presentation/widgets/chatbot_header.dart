import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Header full screen "Tanya Jeruk": avatar asisten, judul, chip AI, profil.
class ChatbotHeader extends StatelessWidget implements PreferredSizeWidget {
  const ChatbotHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppSizes.chatHeaderHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBgColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: AppSizes.chatHeaderHeight,
      leadingWidth: AppSizes.chatLeadingWidth,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: kTextPrimary,
          size: AppSizes.chatBackIcon,
        ),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          _buildAssistantAvatar(),
          const SizedBox(width: AppSizes.chatHeaderGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text('Tanya Jeruk', style: AppTextStyles.chatTitle),
                    const SizedBox(width: AppSizes.chatTitleGap),
                    Container(
                      height: AppSizes.chatAiChipHeight,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.chatAiChipHorizontal,
                      ),
                      decoration: BoxDecoration(
                        color: kChatAiChip,
                        borderRadius: BorderRadius.circular(
                          AppSizes.chatAiChipRadius,
                        ),
                      ),
                      child: Text('AI', style: AppTextStyles.chatAiChip),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.chatHeaderSpacing),
                Text(
                  'Asisten Kebun Solorejo',
                  style: AppTextStyles.chatSubtitle,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSizes.chatPageHorizontal),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSizes.chatProfileButton),
            onTap: () => Navigator.pushNamed(context, '/profile'),
            child: Container(
              width: AppSizes.chatProfileButton,
              height: AppSizes.chatProfileButton,
              decoration: const BoxDecoration(
                color: kLightOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline_rounded,
                size: AppSizes.chatProfileIcon,
                color: kPrimaryOrange,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssistantAvatar() {
    return SizedBox(
      width: AppSizes.chatHeaderAvatar,
      height: AppSizes.chatHeaderAvatar,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: AppSizes.chatHeaderAvatar,
            height: AppSizes.chatHeaderAvatar,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: kPrimaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.eco_rounded,
              color: Colors.white,
              size: AppSizes.chatHeaderAvatarIcon,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: AppSizes.chatOnlineDot,
              height: AppSizes.chatOnlineDot,
              decoration: BoxDecoration(
                color: kChatOnlineDot,
                shape: BoxShape.circle,
                border: Border.all(
                  color: kBgColor,
                  width: AppSizes.chatOnlineBorder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
