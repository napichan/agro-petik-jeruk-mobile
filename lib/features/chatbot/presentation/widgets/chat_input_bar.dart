import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Kolom input chat dengan ikon kamera, mic, dan tombol kirim.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.canSend,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool canSend;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.chatPageHorizontal,
          6,
          AppSizes.chatPageHorizontal,
          AppSizes.chatInputBarVertical,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: AppSizes.chatInputHeight,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.chatInputHorizontal,
                ),
                decoration: BoxDecoration(
                  color: kSurfaceColor,
                  borderRadius: BorderRadius.circular(AppSizes.chatInputRadius),
                  border: Border.all(color: kBorderColor),
                ),
                child: Row(
                  children: [
                    _iconButton(Icons.photo_camera_outlined, context),
                    const SizedBox(width: AppSizes.chatInputIconGap),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        cursorColor: kPrimaryGreen,
                        style: AppTextStyles.chatInput,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) {
                          if (canSend) onSend();
                        },
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Tanyakan seputar kebun jeruk...',
                          hintStyle: AppTextStyles.chatInputHint,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.chatInputIconGap),
                    _iconButton(Icons.mic_none_rounded, context),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSizes.chatInputGap),
            SizedBox(
              width: AppSizes.chatSendButton,
              height: AppSizes.chatSendButton,
              child: ElevatedButton(
                onPressed: canSend ? onSend : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryGreen,
                  disabledBackgroundColor: kChatSendDisabled,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  Icons.send_rounded,
                  size: AppSizes.chatSendIcon,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, BuildContext context) {
    return InkWell(
      onTap: () {
        final messenger = ScaffoldMessenger.of(context);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Segera hadir'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppSizes.chatInputIcon),
      child: Icon(
        icon,
        size: AppSizes.chatInputIcon,
        color: kTextMuted,
      ),
    );
  }
}
