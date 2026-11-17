import '../../domain/entities/account.dart';
import '../../domain/entities/register_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._dataSource);

  final AuthDataSource _dataSource;

  @override
  Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) {
    return _dataSource.register(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
    );
  }

  @override
  Account? get currentUser => _dataSource.currentUser;
}
