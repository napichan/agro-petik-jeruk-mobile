import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppBar bersama halaman Profile dan turunannya: tombol kembali + judul.
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kSurfaceColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 52,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        tooltip: 'Kembali',
        icon: const Icon(Icons.arrow_back, color: kTextPrimary, size: 22),
      ),
      titleSpacing: 0,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kTextPrimary,
        ),
      ),
    );
  }
}
