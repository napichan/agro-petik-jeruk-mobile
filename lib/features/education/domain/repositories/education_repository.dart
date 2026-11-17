import '../entities/education_activity.dart';

abstract class EducationRepository {
  Future<EducationActivity> getActivity(EducationActivityType type);
}
