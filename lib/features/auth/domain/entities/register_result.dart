import 'account.dart';

sealed class RegisterResult {
  const RegisterResult();
}

class RegisterSuccess extends RegisterResult {
  const RegisterSuccess(this.account);

  final Account account;
}

class RegisterFailure extends RegisterResult {
  const RegisterFailure(this.message);

  final String message;
}
