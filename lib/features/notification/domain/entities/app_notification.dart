/// Jenis notifikasi; presentasi memetakannya ke ikon & warna.
enum NotificationType { ticket, harvest, payment, voucher }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timeLabel,
    this.isRead = false,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final String timeLabel;
  final bool isRead;

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      type: type,
      title: title,
      description: description,
      timeLabel: timeLabel,
      isRead: isRead ?? this.isRead,
    );
  }
}
