import 'package:flutter/foundation.dart';

import '../../domain/entities/petik_jeruk_detail.dart';
import '../../domain/usecases/get_petik_jeruk_detail.dart';

class PetikJerukViewModel extends ChangeNotifier {
  PetikJerukViewModel(this._getDetail);

  final GetPetikJerukDetail _getDetail;

  PetikJerukDetail? _detail;
  bool _isLoading = false;
  String? _errorMessage;

  PetikJerukDetail? get detail => _detail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _detail = await _getDetail();
    } catch (_) {
      _errorMessage = 'Gagal memuat detail aktivitas.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
