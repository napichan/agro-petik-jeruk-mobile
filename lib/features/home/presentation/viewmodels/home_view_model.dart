import 'package:flutter/foundation.dart';

import '../../domain/entities/home_content.dart';
import '../../domain/usecases/get_home_content.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._getHomeContent);

  final GetHomeContent _getHomeContent;

  HomeContent? _content;
  bool _isLoading = false;
  String? _errorMessage;

  HomeContent? get content => _content;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _content = await _getHomeContent();
    } catch (_) {
      _errorMessage = 'Gagal memuat beranda. Coba lagi.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
