import 'package:flutter_agrowisatajeruk/core/models/activity_item.dart';
import 'package:flutter_agrowisatajeruk/core/models/facility.dart';

/// Jenis aktivitas edukasi yang punya halaman detail.
enum EducationActivityType { edukasi, wawancara, penelitian }

/// Data lengkap satu aktivitas edukasi untuk halaman detail.
class EducationActivity {
  const EducationActivity({
    required this.title,
    required this.address,
    required this.duration,
    required this.price,
    required this.heroImage,
    required this.activities,
    required this.facilities,
  });

  final String title;
  final String address;
  final String duration;

  /// Harga tiket masuk dalam rupiah.
  final int price;

  /// Path aset gambar hero.
  final String heroImage;

  final List<ActivityItem> activities;
  final List<Facility> facilities;
}
