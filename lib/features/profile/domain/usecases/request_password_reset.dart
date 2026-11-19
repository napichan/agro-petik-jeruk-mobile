import '../repositories/profile_repository.dart';

class RequestPasswordReset {
  const RequestPasswordReset(this._repository);

  final ProfileRepository _repository;

  /// Mengembalikan `true` bila tautan reset berhasil dikirim.
  Future<bool> call(String email) => _repository.requestPasswordReset(email);
}
