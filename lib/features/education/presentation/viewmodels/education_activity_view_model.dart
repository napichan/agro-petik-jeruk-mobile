import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/education_activity.dart';
import '../../domain/usecases/get_education_activity.dart';

class EducationActivityViewModel extends ChangeNotifier {
  EducationActivityViewModel(this._getActivity, this.type);

  final GetEducationActivity _getActivity;
  final EducationActivityType type;

  EducationActivity? _activity;
  bool _isLoading = false;
  String? _errorMessage;

  EducationActivity? get activity => _activity;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Harga tiket masuk terformat, mis. "Rp 20.000".
  String get hargaFormatted {
    final activity = _activity;
    if (activity == null) return '';
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(activity.price);
  }

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _activity = await _getActivity(type);
    } catch (_) {
      _errorMessage = 'Gagal memuat detail aktivitas.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
