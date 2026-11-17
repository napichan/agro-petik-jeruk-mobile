import '../../domain/entities/account.dart';
import '../../domain/entities/register_result.dart';

abstract class AuthDataSource {
  Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Account? get currentUser;
}
