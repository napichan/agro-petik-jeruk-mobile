import '../repositories/profile_repository.dart';

class SignOut {
  const SignOut(this._repository);

  final ProfileRepository _repository;

  Future<void> call() => _repository.signOut();
}
