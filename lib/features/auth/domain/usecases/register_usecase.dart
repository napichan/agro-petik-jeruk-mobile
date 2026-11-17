import '../entities/register_result.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<RegisterResult> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return _repository.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }
}
