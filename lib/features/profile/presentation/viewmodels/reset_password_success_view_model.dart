import 'package:flutter/foundation.dart';

import '../../domain/usecases/sign_out.dart';

/// State halaman konfirmasi reset kata sandi: logout sebelum ke Login.
class ResetPasswordSuccessViewModel extends ChangeNotifier {
  ResetPasswordSuccessViewModel(this._signOut);

  final SignOut _signOut;

  bool _isSigningOut = false;
  String? _errorMessage;

  bool get isSigningOut => _isSigningOut;
  String? get errorMessage => _errorMessage;

  /// Mengakhiri sesi pengguna. `true` bila berhasil.
  Future<bool> signOut() async {
    if (_isSigningOut) return false;
    _isSigningOut = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _signOut();
      return true;
    } catch (_) {
      _errorMessage = 'Gagal keluar dari akun. Coba lagi.';
      return false;
    } finally {
      _isSigningOut = false;
      notifyListeners();
    }
  }
}
