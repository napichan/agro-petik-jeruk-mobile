import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../../domain/entities/chat_message.dart';

/// Bubble teks bot (putih, kiri) dan pengguna (hijau, kanan).
class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final maxWidth =
        MediaQuery.sizeOf(context).width * AppSizes.chatBubbleWidthFactor;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.chatBubbleHorizontal,
                vertical: AppSizes.chatBubbleVertical,
              ),
              decoration: BoxDecoration(
                color: isUser ? kPrimaryGreen : kSurfaceColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    isUser ? AppSizes.chatBubbleRadius : AppSizes.chatBubbleCorner,
                  ),
                  topRight: Radius.circular(
                    isUser ? AppSizes.chatBubbleCorner : AppSizes.chatBubbleRadius,
                  ),
                  bottomLeft: const Radius.circular(AppSizes.chatBubbleRadius),
                  bottomRight: const Radius.circular(AppSizes.chatBubbleRadius),
                ),
                border: isUser ? null : Border.all(color: kBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: isUser
                        ? AppTextStyles.chatUserBubble
                        : AppTextStyles.chatBubble,
                  ),
                  if (message.action != null) ...[
                    const SizedBox(height: AppSizes.chatBubbleActionGap),
                    SizedBox(
                      height: AppSizes.chatCardActionHeight,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          message.action!.route,
                        ),
                        icon: const Icon(
                          Icons.confirmation_number_outlined,
                          size: AppSizes.chatCardActionIcon,
                        ),
                        label: Text(message.action!.label),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          textStyle: AppTextStyles.chatCardButtonGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.chatCardActionRadius,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(height: AppSizes.chatMetaGap),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_timeLabel(message.sentAt), style: AppTextStyles.chatMeta),
                Text(' • ', style: AppTextStyles.chatMeta),
                const Icon(
                  Icons.check_rounded,
                  size: AppSizes.chatMetaIcon,
                  color: kPrimaryGreen,
                ),
                Text(' Terkirim', style: AppTextStyles.chatMeta),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _timeLabel(DateTime? sentAt) {
    final time = sentAt ?? DateTime.now();
    String two(int value) => value.toString().padLeft(2, '0');
    return '${two(time.hour)}.${two(time.minute)}';
  }
}
