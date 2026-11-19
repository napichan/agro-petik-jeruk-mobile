import '../entities/activity_detail.dart';

abstract class ActivityDetailRepository {
  Future<ActivityDetail> getActivityDetail(String id);
}
