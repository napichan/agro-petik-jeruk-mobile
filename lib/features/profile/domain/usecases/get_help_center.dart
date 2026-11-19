import '../entities/help_center.dart';
import '../repositories/profile_repository.dart';

class GetHelpCenter {
  const GetHelpCenter(this._repository);

  final ProfileRepository _repository;

  Future<HelpCenter> call() => _repository.getHelpCenter();
}
