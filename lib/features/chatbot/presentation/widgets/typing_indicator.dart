import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

/// Indikator tiga titik yang beranimasi saat bot sedang menyiapkan balasan.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: AppSizes.chatTypingWidth,
        height: AppSizes.chatTypingHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kSurfaceColor,
          border: Border.all(color: kBorderColor),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSizes.chatBubbleCorner),
            topRight: Radius.circular(AppSizes.chatBubbleRadius),
            bottomLeft: Radius.circular(AppSizes.chatBubbleRadius),
            bottomRight: Radius.circular(AppSizes.chatBubbleRadius),
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                final phase = (_controller.value * 2 * pi) - (index * 0.9);
                final opacity = 0.3 + ((sin(phase) + 1) / 2) * 0.7;
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : AppSizes.chatTypingGap,
                  ),
                  child: Container(
                    width: AppSizes.chatTypingDot,
                    height: AppSizes.chatTypingDot,
                    decoration: BoxDecoration(
                      color: kTextMuted.withValues(alpha: opacity),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
