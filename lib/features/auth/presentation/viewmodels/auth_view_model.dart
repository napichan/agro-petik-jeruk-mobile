import 'package:flutter/foundation.dart';

import '../../domain/entities/account.dart';
import '../../domain/entities/register_result.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._registerUseCase);

  final RegisterUseCase _registerUseCase;

  bool _isLoading = false;
  String? _errorMessage;
  Account? _registeredAccount;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Account? get registeredAccount => _registeredAccount;

  Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _registeredAccount = null;
    notifyListeners();

    try {
      final result = await _registerUseCase(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );

      if (result is RegisterSuccess) {
        _registeredAccount = result.account;
      } else if (result is RegisterFailure) {
        _errorMessage = result.message;
      }

      return result;
    } catch (error) {
      const failure = RegisterFailure(
        'Terjadi kesalahan saat melakukan registrasi.',
      );
      _errorMessage = failure.message;
      return failure;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _errorMessage = null;
    _registeredAccount = null;
    notifyListeners();
  }
}

