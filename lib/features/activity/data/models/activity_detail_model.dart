import '../../domain/entities/activity_detail.dart';
import 'package:flutter_agrowisatajeruk/core/models/activity_item.dart';
import 'package:flutter_agrowisatajeruk/core/models/facility.dart';

/// Model data detail wisata. Dipetakan ke [ActivityDetail] di repository.
class ActivityDetailModel {
  const ActivityDetailModel({
    required this.id,
    required this.title,
    required this.address,
    required this.duration,
    required this.price,
    required this.heroImage,
    required this.activities,
    required this.facilities,
  });

  final String id;
  final String title;
  final String address;
  final String duration;
  final int price;
  final String heroImage;
  final List<ActivityItem> activities;
  final List<Facility> facilities;

  ActivityDetail toEntity() {
    return ActivityDetail(
      id: id,
      title: title,
      address: address,
      duration: duration,
      price: price,
      heroImage: heroImage,
      activities: activities,
      facilities: facilities,
    );
  }
}
