import 'package:flutter/foundation.dart';

import '../../domain/entities/informasi_kebun.dart';
import '../../domain/usecases/get_informasi_kebun.dart';

/// State halaman Informasi: konten syarat & ketentuan kebun.
class InformasiViewModel extends ChangeNotifier {
  InformasiViewModel(this._getInformasiKebun);

  final GetInformasiKebun _getInformasiKebun;

  InformasiKebun? _informasi;
  bool _isLoading = false;
  String? _errorMessage;

  InformasiKebun? get informasi => _informasi;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _informasi = await _getInformasiKebun();
    } catch (_) {
      _errorMessage = 'Gagal memuat informasi kebun. Coba lagi.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
