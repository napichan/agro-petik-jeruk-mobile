import '../../domain/entities/activity_detail.dart';
import '../../domain/repositories/activity_detail_repository.dart';
import '../datasources/activity_detail_mock_data_source.dart';

class ActivityDetailRepositoryImpl implements ActivityDetailRepository {
  const ActivityDetailRepositoryImpl(this._dataSource);

  final ActivityDetailDataSource _dataSource;

  @override
  Future<ActivityDetail> getActivityDetail(String id) async {
    final model = await _dataSource.getActivityDetail(id);
    return model.toEntity();
  }
}
