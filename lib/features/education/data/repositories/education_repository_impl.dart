import '../../domain/entities/education_activity.dart';
import '../../domain/repositories/education_repository.dart';
import '../datasources/education_local_data_source.dart';

class EducationRepositoryImpl implements EducationRepository {
  const EducationRepositoryImpl(this._dataSource);

  final EducationDataSource _dataSource;

  @override
  Future<EducationActivity> getActivity(EducationActivityType type) =>
      _dataSource.getActivity(type);
}
