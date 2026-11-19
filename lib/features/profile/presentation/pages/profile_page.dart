
import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';
import 'package:flutter_agrowisatajeruk/shared/widgets/app_bottom_nav.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/user_profile.dart';
import '../viewmodels/profile_view_model.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_avatar.dart';

/// Halaman Profile — sesuai desain UI "Profile".
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createProfileViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  UserProfile get _profile => _viewModel.profile!;

  /// Membuka Edit Profil, lalu memuat ulang data setelah perubahan disimpan.
  Future<void> _openEditProfile() async {
    final updated = await Navigator.pushNamed(context, '/edit-profil');
    if (!mounted) return;
    if (updated == true) await _viewModel.load();
  }

  Future<void> _signOut() async {
    final success = await _viewModel.signOut();
    if (!mounted) return;

    if (!success) {
      _showMessage(_viewModel.errorMessage ?? 'Gagal keluar dari akun.');
      return;
    }

    // Sesi berakhir: kembali ke halaman Login yang sudah tersedia.
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        if (_viewModel.profile == null) {
          return Scaffold(
            backgroundColor: kBgColor,
            appBar: const ProfileAppBar(title: 'Profile'),
            body: Center(
              child: _viewModel.errorMessage != null
                  ? _buildErrorState()
                  : const CircularProgressIndicator(color: kPrimaryOrange),
            ),
          );
        }
        return _buildPage(context);
      },
    );
  }

  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _viewModel.errorMessage!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 13, color: kTextSecondary),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: _viewModel.load,
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const ProfileAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSizes.screenHorizontal,
          4,
          AppSizes.screenHorizontal,
          AppSizes.scrollBottomPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIdentityCard(),
            const SizedBox(height: 24),
            Text(
              'MENU AKUN',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: kTextPrimary,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            _buildMenuCard(context),
            const SizedBox(height: 24),
            _buildSignOutButton(),
          ],
        ),
      ),
      // Bottom navigation custom (item "Profile" sedang aktif).
      bottomNavigationBar: const AppBottomNav(activeIndex: 3),
    );
  }

  // ── Kartu identitas ──────────────────────────────────────────────────────

  Widget _buildIdentityCard() {
    return _card(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          ProfileAvatar(
            initials: _profile.initials,
            photoBytes: _profile.photoBytes,
            size: 88,
          ),
          const SizedBox(height: 14),
          Text(
            _profile.fullName,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: kTextPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${_profile.email} • ${_profile.phone}',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: kTextMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Menu akun ────────────────────────────────────────────────────────────

  Widget _buildMenuCard(BuildContext context) {
    return _card(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _menuTile(
            icon: Icons.person_outline_rounded,
            label: 'Informasi Akun',
            onTap: _openEditProfile,
          ),
          _menuDivider(),
          _menuTile(
            icon: Icons.help_outline_rounded,
            label: 'Pusat Bantuan',
            onTap: () => Navigator.pushNamed(context, '/pusat-bantuan'),
          ),
        ],
      ),
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 21, color: kPrimaryGreen),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kTextPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: kTextMuted,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuDivider() => const Divider(
        height: 1,
        indent: 51,
        endIndent: 16,
        color: kBorderColor,
      );

  // ── Tombol keluar ────────────────────────────────────────────────────────

  Widget _buildSignOutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _viewModel.isSigningOut ? null : _signOut,
        icon: _viewModel.isSigningOut
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: kPrimaryOrange,
                ),
              )
            : const Icon(
                Icons.logout_rounded,
                color: kPrimaryOrange,
                size: 17,
              ),
        label: Text(
          'Keluar Akun',
          style: GoogleFonts.inter(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: kPrimaryOrange,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: kSurfaceColor,
          foregroundColor: kPrimaryOrange,
          minimumSize: const Size.fromHeight(44),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          side: const BorderSide(color: kPrimaryOrange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ── Helper ───────────────────────────────────────────────────────────────

  Widget _card({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ??
          const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.soft,
      ),
      child: child,
    );
  }
}
