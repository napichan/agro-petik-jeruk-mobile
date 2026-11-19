import '../repositories/profile_repository.dart';

class ResetPassword {
  const ResetPassword(this._repository);

  final ProfileRepository _repository;

  /// Menyimpan kata sandi baru untuk [email].
  /// Mengembalikan `true` bila kata sandi berhasil diperbarui.
  Future<bool> call({required String email, required String newPassword}) =>
      _repository.resetPassword(email, newPassword);
}
