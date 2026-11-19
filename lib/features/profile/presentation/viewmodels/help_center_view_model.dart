import 'package:flutter/foundation.dart';

import '../../domain/entities/help_center.dart';
import '../../domain/usecases/get_help_center.dart';

/// State halaman Pusat Bantuan: data kontak, FAQ, dan FAQ yang sedang terbuka.
class HelpCenterViewModel extends ChangeNotifier {
  HelpCenterViewModel(this._getHelpCenter);

  final GetHelpCenter _getHelpCenter;

  HelpCenter? _helpCenter;
  bool _isLoading = false;
  String? _errorMessage;
  String? _expandedFaqId;

  HelpCenter? get helpCenter => _helpCenter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isExpanded(String faqId) => _expandedFaqId == faqId;

  Future<void> load() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _helpCenter = await _getHelpCenter();
    } catch (_) {
      _errorMessage = 'Gagal memuat Pusat Bantuan. Coba lagi.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Membuka FAQ yang ditekan; menekan FAQ yang sama akan menutupnya.
  void toggleFaq(String faqId) {
    _expandedFaqId = _expandedFaqId == faqId ? null : faqId;
    notifyListeners();
  }
}
