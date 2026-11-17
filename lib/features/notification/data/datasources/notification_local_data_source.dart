import '../../domain/entities/app_notification.dart';

abstract class NotificationDataSource {
  Future<List<AppNotification>> getNotifications();

  Future<void> markAllAsRead();
}

/// Sumber data dummy notifikasi (in-memory).
class NotificationLocalDataSource implements NotificationDataSource {
  final List<AppNotification> _notifications = [
    const AppNotification(
      id: 'n1',
      type: NotificationType.ticket,
      title: 'E-Tiket Siap Digunakan!',
      description:
          'Tiket Petik Jeruk #SLR-20260920 sudah aktif. Tunjukkan kode QR di loket...',
      timeLabel: '10 mnt lalu',
    ),
    const AppNotification(
      id: 'n2',
      type: NotificationType.harvest,
      title: 'Musim Panen Raya Jeruk Keprok 55',
      description:
          'Kondisi buah di Blok A sedang manis maksimal (Brix 14.2°). Waktu terbaik...',
      timeLabel: '2 jam lalu',
    ),
    const AppNotification(
      id: 'n3',
      type: NotificationType.payment,
      title: 'Pembayaran Berhasil Diverifikasi',
      description:
          'Transfer Bank BRI sebesar Rp 40.000 telah disetujui staf loket Solorejo.',
      timeLabel: 'Kemarin, 08.45 WIB',
      isRead: true,
    ),
    const AppNotification(
      id: 'n4',
      type: NotificationType.voucher,
      title: 'Voucher Member Setia Aktif',
      description:
          'Selamat! Anda mendapat voucher potongan petik 15% untuk kunjungan berikutnya.',
      timeLabel: '3 hari lalu',
      isRead: true,
    ),
  ];

  @override
  Future<List<AppNotification>> getNotifications() async =>
      List.unmodifiable(_notifications);

  @override
  Future<void> markAllAsRead() async {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }
}
