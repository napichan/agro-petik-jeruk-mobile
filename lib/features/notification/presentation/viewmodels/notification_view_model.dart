import 'package:flutter/foundation.dart';

import '../../domain/entities/app_notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_all_notifications_read.dart';

class NotificationViewModel extends ChangeNotifier {
  NotificationViewModel(
    this._getNotifications,
    this._markAllAsRead,
  );

  final GetNotifications _getNotifications;
  final MarkAllNotificationsRead _markAllAsRead;

  List<AppNotification> _notifications = const [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _notifications = await _getNotifications();
    } catch (_) {
      _errorMessage = 'Gagal memuat notifikasi.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAllAsRead() async {
    await _markAllAsRead();
    await load();
  }
}
