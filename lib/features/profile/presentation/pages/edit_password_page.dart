import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/edit_password_view_model.dart';
import '../widgets/profile_app_bar.dart';

/// Halaman Edit Kata Sandi — desain UI "Reset Kata Sandi".
class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late final EditPasswordViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createEditPasswordViewModel()..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    final success = await _viewModel.sendResetLink();
    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              _viewModel.errorMessage ?? 'Gagal mengirim tautan reset.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    // Tautan terkirim: lanjut ke halaman konfirmasi (bukan dialog/pop-up).
    Navigator.pushReplacementNamed(
      context,
      '/reset-kata-sandi-berhasil',
      arguments: _viewModel.email,
    );
  }

  void _contactHelp() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Pusat Bantuan segera hadir'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: kBgColor,
          appBar: const ProfileAppBar(title: 'Ubah Kata Sandi'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: _viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: kPrimaryGreen),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: _buildContent(),
                          ),
                        ),
                        _buildHelpFooter(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Kata Sandi',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: kTextPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Masukkan email yang terdaftar pada Anda. Kami akan mengirimkan '
          'tautan untuk mengatur ulang kata sandi.',
          style: GoogleFonts.inter(
            fontSize: 12.5,
            color: kTextSecondary,
            height: 1.65,
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'EMAIL TERDAFTAR',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: kTextSecondary,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F7F9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: kBorderColor),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.mail_outline_rounded,
                size: 18,
                color: kTextMuted,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _viewModel.email.isEmpty ? '-' : _viewModel.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: kTextPrimary,
                  ),
                ),
              ),
              const Icon(
                Icons.check_circle_outline_rounded,
                size: 19,
                color: kPrimaryGreen,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(Icons.info_outline, size: 12, color: kTextMuted),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                'Pastikan email aktif dan dapat menerima pesan masuk.',
                style: GoogleFonts.inter(fontSize: 10.5, color: kTextMuted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _viewModel.isSending ? null : _sendResetLink,
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryGreen,
              disabledBackgroundColor: kPrimaryGreen.withValues(alpha: 0.6),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _viewModel.isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kirim Tautan Reset',
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 17,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text.rich(
            TextSpan(
              style: GoogleFonts.inter(
                fontSize: 10.5,
                color: kTextMuted,
                height: 1.6,
              ),
              children: [
                const TextSpan(
                  text: 'Tidak menerima email? Periksa folder Spam atau '
                      'kirim ulang dalam ',
                ),
                TextSpan(
                  text: '60s',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: kPrimaryGreen,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildHelpFooter() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Butuh bantuan seputar akun? ',
            style: GoogleFonts.inter(fontSize: 11.5, color: kTextMuted),
          ),
          GestureDetector(
            onTap: _contactHelp,
            child: Text(
              'Hubungi Bantuan',
              style: GoogleFonts.inter(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: kPrimaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
