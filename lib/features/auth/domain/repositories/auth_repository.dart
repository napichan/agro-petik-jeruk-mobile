import '../entities/account.dart';
import '../entities/register_result.dart';

abstract class AuthRepository {
  Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Account? get currentUser;
}

