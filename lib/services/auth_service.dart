import 'package:flutter/foundation.dart';

/// Model data akun untuk penyimpanan dummy (in-memory).
class Account {
  const Account({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.createdAt,
  });
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final DateTime createdAt;

  /// Nama depan untuk sapaan (mis. "Budi" dari "Budi Santoso").
  String get firstName => fullName.trim().split(RegExp(r'\s+')).first;
}

/// Hasil operasi registrasi.
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

/// Layanan autentikasi dengan penyimpanan data **dummy** (in-memory).
///
/// Data disimpan di memori dan diisi beberapa akun contoh, sehingga alur
/// register bisa dicoba tanpa backend. Simulasi latensi jaringan kecil
/// agar UX (loading state) terasa nyata.
class AuthService {
  AuthService._();

  /// Instance tunggal untuk seluruh aplikasi.
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

  /// Akun yang sedang "login" (didaftarkan terakhir), bisa null.
  Account? currentUser;

  /// Mendaftarkan akun baru ke penyimpanan dummy.
  ///
  /// Mengembalikan [RegisterFailure] bila email sudah terdaftar atau
  /// data tidak valid; [RegisterSuccess] bila berhasil.
  Future<RegisterResult> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Simulasi latensi jaringan.
    await Future<void>.delayed(const Duration(milliseconds: 600));

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedPhone = phone.trim();

    // Validasi ulang di sisi "server" dummy.
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
      (a) => a.email.toLowerCase() == normalizedEmail,
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

  /// Daftar akun dummy yang tersimpan (untuk keperluan debug/demo).
  List<Account> get accounts => List.unmodifiable(_accounts);

  /// Reset penyimpanan dummy ke kondisi awal (dipakai di test).
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
