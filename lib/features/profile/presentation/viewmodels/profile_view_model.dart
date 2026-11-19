import 'package:flutter/foundation.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/sign_out.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._getProfile, this._signOut);

  final GetProfile _getProfile;
  final SignOut _signOut;

  UserProfile? _profile;
  bool _isLoading = false;
  bool _isSigningOut = false;
  String? _errorMessage;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  bool get isSigningOut => _isSigningOut;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profile = await _getProfile();
    } catch (_) {
      _errorMessage = 'Gagal memuat profil.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Mengakhiri sesi pengguna. Mengembalikan `true` bila berhasil.
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
