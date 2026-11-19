import '../entities/activity_detail.dart';
import '../repositories/activity_detail_repository.dart';

class GetActivityDetail {
  const GetActivityDetail(this._repository);

  final ActivityDetailRepository _repository;

  Future<ActivityDetail> call(String id) => _repository.getActivityDetail(id);
}
