import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/pages/edit_password_page.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/pages/help_center_page.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/pages/new_password_page.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/pages/reset_password_success_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'test_font_helpers.dart';

Widget _app() {
  return MaterialApp(
    home: const ProfilePage(),
    routes: {
      '/edit-profil': (_) => const EditProfilePage(),
      '/edit-kata-sandi': (_) => const EditPasswordPage(),
      '/reset-kata-sandi-berhasil': (_) => const ResetPasswordSuccessPage(),
      '/buat-kata-sandi-baru': (_) => const NewPasswordPage(),
      '/pusat-bantuan': (_) => const HelpCenterPage(),
      '/login': (_) => const Scaffold(body: Text('LoginPlaceholder')),
    },
  );
}

/// Memuat halaman profil beserta data dummy-nya (delay baca 250 ms).
Future<void> _loadProfile(WidgetTester tester) async {
  await tester.pumpWidget(_app());
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pump(const Duration(milliseconds: 100));
}

/// Menunggu transisi rute dan pemuatan data halaman tujuan.
Future<void> _settleNavigation(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('navigasi Profile -> Edit Profil -> Ubah Kata Sandi -> '
      'Reset berhasil -> Buat Kata Sandi Baru -> Login', (tester) async {
    ignoreTestFontOverflow();

    await _loadProfile(tester);
    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.text('Informasi Akun'), findsOneWidget);

    // Profile -> Edit Profil.
    await tester.tap(find.text('Informasi Akun'));
    await _settleNavigation(tester);
    expect(find.byType(EditProfilePage), findsOneWidget);
    expect(find.text('Informasi akun'), findsOneWidget);

    // Edit Profil -> Ubah Kata Sandi.
    await tester.ensureVisible(find.text('Ubah Kata Sandi'));
    await tester.pump();
    await tester.tap(find.text('Ubah Kata Sandi'));
    await _settleNavigation(tester);
    expect(find.byType(EditPasswordPage), findsOneWidget);
    expect(find.text('Reset Kata Sandi'), findsOneWidget);

    // Kirim tautan reset (delay 1200 ms) -> halaman konfirmasi.
    await tester.tap(find.text('Kirim Tautan Reset'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(ResetPasswordSuccessPage), findsOneWidget);
    expect(find.text('Link Reset Kata Sandi Terkirim'), findsOneWidget);

    // Halaman konfirmasi -> Buat Kata Sandi Baru.
    await tester.tap(find.text('Buat Kata Sandi Baru'));
    await _settleNavigation(tester);
    expect(find.byType(NewPasswordPage), findsOneWidget);
    expect(find.text('Buat Kata Sandi Baru'), findsOneWidget);
    expect(
      find.textContaining('Masukkan kata sandi untuk akun'),
      findsOneWidget,
    );

    // Isi kata sandi baru lalu simpan (delay 1200 ms).
    await tester.enterText(find.byType(TextFormField).at(0), 'jeruk12345');
    await tester.enterText(find.byType(TextFormField).at(1), 'jeruk12345');
    await tester.pump();
    await tester.ensureVisible(find.text('Simpan Kata Sandi'));
    await tester.pump();
    await tester.tap(find.text('Simpan Kata Sandi'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1300));
    await _settleNavigation(tester);

    expect(find.text('LoginPlaceholder'), findsOneWidget);
    expect(find.byType(NewPasswordPage), findsNothing);
  });

  testWidgets('Login Kembali dari halaman konfirmasi reset kembali ke Login', (
    tester,
  ) async {
    ignoreTestFontOverflow();

    await _loadProfile(tester);
    await tester.tap(find.text('Informasi Akun'));
    await _settleNavigation(tester);
    await tester.ensureVisible(find.text('Ubah Kata Sandi'));
    await tester.pump();
    await tester.tap(find.text('Ubah Kata Sandi'));
    await _settleNavigation(tester);

    await tester.tap(find.text('Kirim Tautan Reset'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 1300));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(ResetPasswordSuccessPage), findsOneWidget);

    await tester.tap(find.text('Login Kembali'));
    await _settleNavigation(tester);
    expect(find.text('LoginPlaceholder'), findsOneWidget);
    expect(find.byType(ResetPasswordSuccessPage), findsNothing);
  });

  testWidgets('Pusat Bantuan: buka FAQ, tutup FAQ, dan lihat detail kontak', (
    tester,
  ) async {
    ignoreTestFontOverflow();

    await _loadProfile(tester);
    await tester.ensureVisible(find.text('Pusat Bantuan'));
    await tester.pump();
    await tester.tap(find.text('Pusat Bantuan'));
    await _settleNavigation(tester);

    expect(find.byType(HelpCenterPage), findsOneWidget);
    expect(find.text('WhatsApp Pengelola'), findsOneWidget);
    expect(find.text('Loket & Call Center'), findsOneWidget);
    expect(find.text(
      'Bagaimana cara reschedule tanggal kunjungan?',
    ), findsOneWidget);

    // FAQ tertutup: jawaban belum tampil.
    expect(find.textContaining('Ajukan perubahan tanggal'), findsNothing);

    // Buka FAQ lewat accordion.
    await tester.tap(
      find.text('Bagaimana cara reschedule tanggal kunjungan?'),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.textContaining('Ajukan perubahan tanggal'), findsOneWidget);

    // FAQ lain bisa dibuka dan yang pertama tertutup kembali.
    await tester.ensureVisible(
      find.text('Metode pembayaran apa saja yang diterima?'),
    );
    await tester.pump();
    await tester.tap(find.text('Metode pembayaran apa saja yang diterima?'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.textContaining('transfer bank, QRIS'), findsOneWidget);
    expect(find.textContaining('Ajukan perubahan tanggal'), findsNothing);

    // Tekan lagi untuk menutup.
    await tester.tap(find.text('Metode pembayaran apa saja yang diterima?'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.textContaining('transfer bank, QRIS'), findsNothing);

    // Kartu kontak membuka detail beserta aksi salin nomor.
    await tester.ensureVisible(find.text('WhatsApp Pengelola'));
    await tester.pump();
    await tester.tap(find.text('WhatsApp Pengelola'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Salin Nomor'), findsOneWidget);
    expect(find.text('+62 812-3456-7890'), findsOneWidget);

    await tester.tap(find.text('Salin Nomor'));
    await tester.pumpAndSettle();
    expect(find.text('Salin Nomor'), findsNothing);
    expect(
      find.textContaining('berhasil disalin'),
      findsOneWidget,
    );
  });

  testWidgets('Edit Profil kembali ke Profile lewat tombol kembali', (
    tester,
  ) async {
    ignoreTestFontOverflow();

    await _loadProfile(tester);
    await tester.tap(find.text('Informasi Akun'));
    await _settleNavigation(tester);
    expect(find.byType(EditProfilePage), findsOneWidget);

    await tester.tap(find.byTooltip('Kembali'));
    await _settleNavigation(tester);

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(find.byType(EditProfilePage), findsNothing);
  });
}
