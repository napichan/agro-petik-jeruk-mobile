import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/reset_password_success_view_model.dart';

/// Halaman konfirmasi Reset Kata Sandi berhasil.
///
/// Email tujuan dikirim lewat `arguments` rute `/reset-kata-sandi-berhasil`.
class ResetPasswordSuccessPage extends StatefulWidget {
  const ResetPasswordSuccessPage({super.key});

  @override
  State<ResetPasswordSuccessPage> createState() =>
      _ResetPasswordSuccessPageState();
}

class _ResetPasswordSuccessPageState extends State<ResetPasswordSuccessPage> {
  late final ResetPasswordSuccessViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createResetPasswordSuccessViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  String get _email {
    final args = ModalRoute.of(context)?.settings.arguments;
    return args is String && args.trim().isNotEmpty ? args : '-';
  }

  /// Melanjutkan ke langkah terakhir: membuat kata sandi baru.
  void _openNewPassword() {
    Navigator.pushNamed(
      context,
      '/buat-kata-sandi-baru',
      arguments: _email,
    );
  }

  Future<void> _backToLogin() async {
    final success = await _viewModel.signOut();
    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              _viewModel.errorMessage ?? 'Gagal keluar dari akun.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    // Sesi berakhir: halaman Login yang sudah ada menjadi halaman awal.
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: kBgColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: _buildCard(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorderColor),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: kLightGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 36,
              color: kPrimaryGreen,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Link Reset Kata Sandi Terkirim',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: kTextPrimary,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Tautan untuk mengatur ulang kata sandi telah kami kirim ke alamat '
            'email berikut. Silakan periksa kotak masuk Anda.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: kTextSecondary,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kBorderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mail_outline_rounded,
                  size: 17,
                  color: kTextMuted,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    _email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: kTextPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _openNewPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Buat Kata Sandi Baru',
                style: GoogleFonts.inter(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: _viewModel.isSigningOut ? null : _backToLogin,
            child: _viewModel.isSigningOut
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: kPrimaryGreen,
                    ),
                  )
                : Text(
                    'Login Kembali',
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: kTextSecondary,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
