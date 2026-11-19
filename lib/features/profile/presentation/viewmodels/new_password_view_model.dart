import 'package:flutter/widgets.dart';

import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/sign_out.dart';

/// State dan logic halaman \"Buat Kata Sandi Baru\".
///
/// Dipakai setelah pengguna membuka tautan reset dari email: kata sandi baru
/// disimpan, lalu sesi lama diakhiri agar pengguna masuk kembali.
class NewPasswordViewModel extends ChangeNotifier {
  NewPasswordViewModel(this._resetPassword, this._signOut);

  final ResetPassword _resetPassword;
  final SignOut _signOut;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();

  String email = '';
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;
  bool _isSaving = false;
  String? _errorMessage;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmation => _obscureConfirmation;
  bool get isSaving => _isSaving;
  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmationVisibility() {
    _obscureConfirmation = !_obscureConfirmation;
    notifyListeners();
  }

  /// Menyimpan kata sandi baru. `true` bila berhasil.
  Future<bool> save() async {
    if (_isSaving) return false;

    final error = validatePassword(passwordController.text) ??
        validateConfirmation(
          confirmationController.text,
          passwordController.text,
        );
    if (error != null) {
      _errorMessage = error;
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _resetPassword(
        email: email,
        newPassword: passwordController.text,
      );
      if (!success) {
        _errorMessage = 'Gagal menyimpan kata sandi baru. Coba lagi.';
        return false;
      }

      // Sesi lama tidak berlaku lagi setelah kata sandi berubah.
      await _signOut();
      return true;
    } catch (_) {
      _errorMessage = 'Gagal menyimpan kata sandi baru. Coba lagi.';
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  /// Minimal 8 karakter dan kombinasi huruf dengan angka.
  static String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Kata sandi wajib diisi';
    if (password.length < 8) return 'Kata sandi minimal 8 karakter';
    if (!RegExp(r'[A-Za-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password)) {
      return 'Gunakan kombinasi huruf dan angka';
    }
    return null;
  }

  static String? validateConfirmation(String? value, String password) {
    final confirmation = value ?? '';
    if (confirmation.isEmpty) return 'Konfirmasi kata sandi wajib diisi';
    if (confirmation != password) return 'Konfirmasi kata sandi tidak cocok';
    return null;
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmationController.dispose();
    super.dispose();
  }
}
