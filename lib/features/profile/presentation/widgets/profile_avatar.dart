import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// Avatar profil bulat: menampilkan foto bila ada, selain itu inisial nama.
///
/// Bila [onCameraTap] diisi, sebuah tombol kamera kecil muncul di sudut
/// kanan bawah untuk mengganti foto profil.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.initials,
    this.photoBytes,
    this.size = 72,
    this.onCameraTap,
    this.showRing = false,
  });

  final String initials;
  final Uint8List? photoBytes;
  final double size;
  final VoidCallback? onCameraTap;
  final bool showRing;

  @override
  Widget build(BuildContext context) {
    final avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: kLightOrange,
        shape: BoxShape.circle,
        border: showRing
            ? Border.all(color: kPrimaryGreen.withValues(alpha: 0.35), width: 2)
            : null,
      ),
      child: ClipOval(
        child: photoBytes != null
            ? Image.memory(photoBytes!, fit: BoxFit.cover)
            : Center(
                child: Text(
                  initials,
                  style: GoogleFonts.inter(
                    fontSize: size * 0.3,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryOrange,
                  ),
                ),
              ),
      ),
    );

    if (onCameraTap == null) return avatar;

    final badgeSize = size * 0.36;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatar,
        Positioned(
          right: -2,
          bottom: -2,
          child: Material(
            color: kSurfaceColor,
            shape: const CircleBorder(
              side: BorderSide(color: kBorderColor, width: 1.2),
            ),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onCameraTap,
              child: SizedBox(
                width: badgeSize,
                height: badgeSize,
                child: Icon(
                  Icons.photo_camera_outlined,
                  size: badgeSize * 0.56,
                  color: kTextSecondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
