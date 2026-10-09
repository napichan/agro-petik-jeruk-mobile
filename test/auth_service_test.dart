import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_agrowisatajeruk/services/auth_service.dart';

void main() {
  setUp(() {
    AuthService.instance.reset();
  });

  group('AuthService.register (data dummy)', () {
    test('berhasil mendaftarkan akun baru dan menyimpannya', () async {
      final result = await AuthService.instance.register(
        fullName: 'Andi Wijaya',
        email: 'andi@example.com',
        phone: '081122334455',
        password: 'rahasia123',
      );

      expect(result, isA<RegisterSuccess>());
      final account = (result as RegisterSuccess).account;
      expect(account.fullName, 'Andi Wijaya');
      expect(account.email, 'andi@example.com');
      expect(account.firstName, 'Andi');
      expect(AuthService.instance.currentUser?.email, 'andi@example.com');
      // 2 seed + 1 baru.
      expect(AuthService.instance.accounts.length, 3);
    });

    test('menolak email yang sudah terdaftar (seed)', () async {
      final result = await AuthService.instance.register(
        fullName: 'Budi Duplikat',
        email: 'budi@example.com',
        phone: '081122334455',
        password: 'rahasia123',
      );

      expect(result, isA<RegisterFailure>());
      expect((result as RegisterFailure).message, contains('sudah terdaftar'));
      expect(AuthService.instance.accounts.length, 2);
    });

    test('menolak email duplikat tanpa memperhatikan huruf besar/kecil',
        () async {
      final result = await AuthService.instance.register(
        fullName: 'Siti Duplikat',
        email: '  SITI@Example.COM ',
        phone: '081122334455',
        password: 'rahasia123',
      );

      expect(result, isA<RegisterFailure>());
    });

    test('menolak password kurang dari 8 karakter', () async {
      final result = await AuthService.instance.register(
        fullName: 'Andi Wijaya',
        email: 'andi@example.com',
        phone: '081122334455',
        password: 'pendek',
      );

      expect(result, isA<RegisterFailure>());
      expect((result as RegisterFailure).message, contains('minimal 8'));
    });

    test('menolak nama terlalu pendek', () async {
      final result = await AuthService.instance.register(
        fullName: 'A',
        email: 'andi@example.com',
        phone: '081122334455',
        password: 'rahasia123',
      );

      expect(result, isA<RegisterFailure>());
      expect((result as RegisterFailure).message, contains('Nama lengkap'));
    });

    test('menolak No.Hp tidak valid', () async {
      final result = await AuthService.instance.register(
        fullName: 'Andi Wijaya',
        email: 'andi@example.com',
        phone: '123',
        password: 'rahasia123',
      );

      expect(result, isA<RegisterFailure>());
      expect((result as RegisterFailure).message, contains('No.Hp'));
    });
  });
}
