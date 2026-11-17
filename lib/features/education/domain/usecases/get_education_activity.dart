import '../entities/education_activity.dart';
import '../repositories/education_repository.dart';

class GetEducationActivity {
  const GetEducationActivity(this._repository);

  final EducationRepository _repository;

  Future<EducationActivity> call(EducationActivityType type) =>
      _repository.getActivity(type);
}
