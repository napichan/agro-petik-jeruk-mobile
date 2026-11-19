import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/new_password_view_model.dart';
import '../widgets/profile_app_bar.dart';

/// Halaman "Buat Kata Sandi Baru" — langkah terakhir setelah tautan reset
/// kata sandi dibuka dari email.
///
/// Email tujuan dikirim lewat `arguments` rute `/buat-kata-sandi-baru`.
class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  late final NewPasswordViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  static const Color _inputFillColor = Color(0xFFF6F7F9);

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createNewPasswordViewModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    _viewModel.email = args is String && args.trim().isNotEmpty
        ? args.trim()
        : '-';
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final success = await _viewModel.save();
    if (!mounted) return;

    if (!success) {
      _showMessage(_viewModel.errorMessage ?? 'Gagal menyimpan kata sandi.');
      return;
    }

    _showMessage('Kata sandi berhasil diperbarui. Silakan masuk kembali.');
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _contactHelp() {
    _showMessage('Pusat Bantuan segera hadir');
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
        return Scaffold(
          backgroundColor: kBgColor,
          appBar: const ProfileAppBar(title: 'Ubah Kata Sandi'),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(key: _formKey, child: _buildContent()),
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
          'Buat Kata Sandi Baru',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: kTextPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            style: GoogleFonts.inter(
              fontSize: 12.5,
              color: kTextSecondary,
              height: 1.65,
            ),
            children: [
              const TextSpan(text: 'Masukkan kata sandi untuk akun '),
              TextSpan(
                text: _viewModel.email,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  color: kTextPrimary,
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 28),
        _fieldLabel('Kata Sandi Baru'),
        const SizedBox(height: 8),
        TextFormField(
          controller: _viewModel.passwordController,
          obscureText: _viewModel.obscurePassword,
          validator: NewPasswordViewModel.validatePassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          style: _inputStyle,
          decoration: _inputDecoration(
            hint: 'Masukkan kata sandi baru',
            suffixIcon: _visibilityToggle(
              obscured: _viewModel.obscurePassword,
              onPressed: _viewModel.togglePasswordVisibility,
            ),
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
                'Minimal 8 karakter kombinasi huruf dan angka',
                style: GoogleFonts.inter(fontSize: 10.5, color: kTextMuted),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _fieldLabel('Konfirmasi Kata Sandi Baru'),
        const SizedBox(height: 8),
        TextFormField(
          controller: _viewModel.confirmationController,
          obscureText: _viewModel.obscureConfirmation,
          validator: (value) => NewPasswordViewModel.validateConfirmation(
            value,
            _viewModel.passwordController.text,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _save(),
          style: _inputStyle,
          decoration: _inputDecoration(
            hint: 'Ulangi kata sandi baru',
            suffixIcon: _visibilityToggle(
              obscured: _viewModel.obscureConfirmation,
              onPressed: _viewModel.toggleConfirmationVisibility,
            ),
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _viewModel.isSaving ? null : _save,
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
            child: _viewModel.isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Simpan Kata Sandi',
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
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
            'Butuh bantuan? ',
            style: GoogleFonts.inter(fontSize: 11.5, color: kTextMuted),
          ),
          GestureDetector(
            onTap: _contactHelp,
            child: Text(
              'Hubungi Bantuan Kebun',
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

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: kTextPrimary,
      ),
    );
  }

  Widget _visibilityToggle({
    required bool obscured,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      tooltip: obscured ? 'Tampilkan kata sandi' : 'Sembunyikan kata sandi',
      icon: Icon(
        obscured
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        size: 19,
        color: kTextMuted,
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(fontSize: 12, color: kTextMuted),
      prefixIcon: const Icon(
        Icons.lock_outline_rounded,
        size: 18,
        color: kTextMuted,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: _inputFillColor,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kPrimaryGreen, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kDangerColor, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kDangerColor, width: 1.2),
      ),
    );
  }

  static final TextStyle _inputStyle = GoogleFonts.inter(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: kTextPrimary,
  );
}
