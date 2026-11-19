import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/activity_detail.dart';
import '../../domain/usecases/get_activity_detail.dart';

class DetailWisataViewModel extends ChangeNotifier {
  DetailWisataViewModel(this._getActivityDetail);

  final GetActivityDetail _getActivityDetail;

  ActivityDetail? _detail;
  bool _isLoading = false;
  String? _errorMessage;

  ActivityDetail? get detail => _detail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Harga tiket masuk terformat, mis. "Rp 20.000".
  String get hargaFormatted {
    final detail = _detail;
    if (detail == null) return '';
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(detail.price);
  }

  Future<void> load(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _detail = await _getActivityDetail(id);
    } catch (_) {
      _errorMessage = 'Gagal memuat detail wisata.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
