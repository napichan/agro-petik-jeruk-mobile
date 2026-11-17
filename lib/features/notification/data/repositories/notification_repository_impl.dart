import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._dataSource);

  final NotificationDataSource _dataSource;

  @override
  Future<List<AppNotification>> getNotifications() =>
      _dataSource.getNotifications();

  @override
  Future<void> markAllAsRead() => _dataSource.markAllAsRead();
}
