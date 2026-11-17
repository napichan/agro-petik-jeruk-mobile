import 'package:flutter/foundation.dart';

import '../../domain/entities/account.dart';
import '../../domain/entities/register_result.dart';
import 'auth_data_source.dart';

export '../../domain/entities/account.dart';
export '../../domain/entities/register_result.dart';

/// Layanan autentikasi dummy (in-memory).
/// Nantinya implementasi ini dapat diganti dengan API backend.
class AuthService implements AuthDataSource {
  AuthService._();

  static final AuthService instance = AuthService._();

  final List<Account> _accounts = [
    Account(
      id: '1',
      fullName: 'Budi Santoso',
      email: 'budi@example.com',
      phone: '081234567890',
      createdAt: DateTime(2026, 1, 1),
    ),
    Account(
      id: '2',
      fullName: 'Siti Aminah',
      email: 'siti@example.com',
      phone: '081987654321',
      createdAt: DateTime(2026, 2, 14),
    ),
  ];

  @override
  Account? currentUser;

  @override
  Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPhone = phone.trim();

    if (fullName.trim().length < 3) {
      return const RegisterFailure('Nama lengkap minimal 3 karakter');
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(normalizedEmail)) {
      return const RegisterFailure('Format email tidak valid');
    }

    if (!RegExp(r'^[0-9+\-\s]{8,}$').hasMatch(normalizedPhone)) {
      return const RegisterFailure('No.Hp tidak valid');
    }

    if (password.length < 8) {
      return const RegisterFailure('Kata sandi minimal 8 karakter');
    }

    final emailTaken = _accounts.any(
      (account) => account.email.toLowerCase() == normalizedEmail,
    );

    if (emailTaken) {
      return const RegisterFailure(
        'Email sudah terdaftar. Gunakan email lain atau masuk.',
      );
    }

    final account = Account(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      fullName: fullName.trim(),
      email: normalizedEmail,
      phone: normalizedPhone,
      createdAt: DateTime.now(),
    );

    _accounts.add(account);
    currentUser = account;

    return RegisterSuccess(account);
  }

  List<Account> get accounts => List.unmodifiable(_accounts);

  @visibleForTesting
  void reset() {
    _accounts
      ..clear()
      ..addAll([
        Account(
          id: '1',
          fullName: 'Budi Santoso',
          email: 'budi@example.com',
          phone: '081234567890',
          createdAt: DateTime(2026, 1, 1),
        ),
        Account(
          id: '2',
          fullName: 'Siti Aminah',
          email: 'siti@example.com',
          phone: '081987654321',
          createdAt: DateTime(2026, 2, 14),
        ),
      ]);

    currentUser = null;
  }
}


