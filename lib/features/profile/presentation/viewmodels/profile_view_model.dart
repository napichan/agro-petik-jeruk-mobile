import 'package:flutter/foundation.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_profile.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this._getProfile);

  final GetProfile _getProfile;

  UserProfile? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  UserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
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
}
