import 'package:flutter/foundation.dart';

import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/request_password_reset.dart';

/// State dan logic halaman Edit Kata Sandi (reset lewat email).
class EditPasswordViewModel extends ChangeNotifier {
  EditPasswordViewModel(this._getProfile, this._requestPasswordReset);

  final GetProfile _getProfile;
  final RequestPasswordReset _requestPasswordReset;

  String _email = '';
  bool _isLoading = false;
  bool _isSending = false;
  String? _errorMessage;

  String get email => _email;
  bool get isLoading => _isLoading;
  bool get isSending => _isSending;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final profile = await _getProfile();
      _email = profile.email;
    } catch (_) {
      _errorMessage = 'Gagal memuat email akun.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Mensimulasikan pengiriman tautan reset. `true` bila berhasil.
  Future<bool> sendResetLink() async {
    if (_isSending || _email.isEmpty) return false;

    _isSending = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _requestPasswordReset(_email);
      if (!success) {
        _errorMessage = 'Gagal mengirim tautan reset. Periksa email Anda.';
      }
      return success;
    } catch (_) {
      _errorMessage = 'Gagal mengirim tautan reset. Coba lagi.';
      return false;
    } finally {
      _isSending = false;
      notifyListeners();
    }
  }
}
