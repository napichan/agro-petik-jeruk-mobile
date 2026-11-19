import 'package:flutter_agrowisatajeruk/features/auth/data/datasources/auth_service.dart';
import 'package:flutter_agrowisatajeruk/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/entities/faq_item.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/entities/help_center.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/entities/profile_update.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/get_help_center.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/get_profile.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/request_password_reset.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/reset_password.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/sign_out.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/update_profile.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/edit_password_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/edit_profile_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/help_center_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/new_password_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/profile_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/reset_password_success_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

const _initialProfile = UserProfile(
  fullName: 'Budi Santoso',
  email: 'budi@example.com',
  phone: '081234567890',
  memberLabel: 'Member Setia',
  birthDate: null,
  stats: [
    ProfileStat(label: 'Tiket Aktif', value: '1'),
  ],
);

const _sampleHelpCenter = HelpCenter(
  contacts: [
    HelpContact(
      channel: HelpChannel.whatsapp,
      title: 'WhatsApp Pengelola',
      subtitle: 'Respon cepat < 10 mnt',
      description: 'Chat pengelola kebun.',
      number: '+62 812-3456-7890',
    ),
  ],
  faqs: [
    FaqItem(
      id: 'faq-1',
      category: 'Kunjungan & Jadwal',
      question: 'Bagaimana cara reschedule tanggal kunjungan?',
      answer: 'Ajukan lewat WhatsApp pengelola.',
    ),
    FaqItem(
      id: 'faq-2',
      category: 'Pembayaran',
      question: 'Metode pembayaran apa saja yang diterima?',
      answer: 'Transfer bank, QRIS, dan tunai.',
    ),
  ],
);

class _FakeProfileRepository implements ProfileRepository {
  UserProfile profile = _initialProfile;
  bool updateShouldFail = false;
  bool resetResult = true;
  bool resetPasswordResult = true;
  bool signOutShouldFail = false;
  bool didSignOut = false;
  ProfileUpdate? lastUpdate;
  String? lastResetEmail;
  String? lastResetPasswordEmail;
  String? lastNewPassword;
  bool helpCenterShouldFail = false;

  @override
  Future<UserProfile> getProfile() async => profile;

  @override
  Future<UserProfile> updateProfile(ProfileUpdate update) async {
    if (updateShouldFail) throw Exception('gagal simpan');
    lastUpdate = update;
    return profile = UserProfile(
      fullName: update.fullName.trim(),
      email: update.email.trim().toLowerCase(),
      phone: update.phone.trim(),
      memberLabel: profile.memberLabel,
      birthDate: update.birthDate ?? profile.birthDate,
      memberSince: profile.memberSince,
      photoBytes: update.photoBytes ?? profile.photoBytes,
      stats: profile.stats,
    );
  }

  @override
  Future<bool> requestPasswordReset(String email) async {
    lastResetEmail = email;
    return resetResult;
  }

  @override
  Future<bool> resetPassword(String email, String newPassword) async {
    lastResetPasswordEmail = email;
    lastNewPassword = newPassword;
    return resetPasswordResult;
  }

  @override
  Future<HelpCenter> getHelpCenter() async {
    if (helpCenterShouldFail) throw Exception('gagal memuat');
    return _sampleHelpCenter;
  }

  @override
  Future<void> signOut() async {
    if (signOutShouldFail) throw Exception('gagal keluar');
    didSignOut = true;
  }
}

void main() {
  group('ProfileViewModel', () {
    late _FakeProfileRepository repository;
    late ProfileViewModel viewModel;

    setUp(() {
      repository = _FakeProfileRepository();
      viewModel = ProfileViewModel(
        GetProfile(repository),
        SignOut(repository),
      );
    });

    tearDown(() => viewModel.dispose());

    test('load menampilkan data profil dan mengakhiri loading', () async {
      expect(viewModel.profile, isNull);

      await viewModel.load();

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.errorMessage, isNull);
      expect(viewModel.profile?.fullName, 'Budi Santoso');
      expect(viewModel.profile?.initials, 'BS');
    });

    test('signOut mengakhiri sesi melalui repository', () async {
      final success = await viewModel.signOut();

      expect(success, isTrue);
      expect(repository.didSignOut, isTrue);
      expect(viewModel.isSigningOut, isFalse);
    });

    test('signOut menampilkan pesan bila gagal', () async {
      repository.signOutShouldFail = true;

      final success = await viewModel.signOut();

      expect(success, isFalse);
      expect(viewModel.errorMessage, isNotNull);
    });
  });

  group('EditProfileViewModel', () {
    late _FakeProfileRepository repository;
    late EditProfileViewModel viewModel;

    setUp(() {
      repository = _FakeProfileRepository();
      viewModel = EditProfileViewModel(
        GetProfile(repository),
        UpdateProfile(repository),
      );
    });

    tearDown(() => viewModel.dispose());

    test('load mengisi form dari profil tersimpan', () async {
      await viewModel.load();

      expect(viewModel.nameController.text, 'Budi Santoso');
      expect(viewModel.emailController.text, 'budi@example.com');
      expect(viewModel.phoneController.text, '081234567890');
      expect(viewModel.isLoading, isFalse);
    });

    test('save menolak input tidak valid', () async {
      await viewModel.load();
      viewModel.nameController.text = 'Bu';

      expect(await viewModel.save(), isFalse);
      expect(viewModel.errorMessage, contains('minimal 3 karakter'));
      expect(repository.lastUpdate, isNull);
    });

    test('save menyimpan perubahan dan mengembalikan true', () async {
      await viewModel.load();
      viewModel.nameController.text = '  Budi Santoso Baru  ';
      viewModel.emailController.text = 'BUDI.BARU@EXAMPLE.COM';
      viewModel.phoneController.text = '0812 9999 8888';

      expect(await viewModel.save(), isTrue);

      expect(repository.lastUpdate?.fullName, '  Budi Santoso Baru  ');
      expect(viewModel.profile?.fullName, 'Budi Santoso Baru');
      expect(viewModel.profile?.email, 'budi.baru@example.com');
      expect(viewModel.errorMessage, isNull);
    });
  });

  group('EditPasswordViewModel', () {
    late _FakeProfileRepository repository;
    late EditPasswordViewModel viewModel;

    setUp(() {
      repository = _FakeProfileRepository();
      viewModel = EditPasswordViewModel(
        GetProfile(repository),
        RequestPasswordReset(repository),
      );
    });

    tearDown(() => viewModel.dispose());

    test('load mengambil email akun lalu mengirim tautan reset', () async {
      await viewModel.load();
      expect(viewModel.email, 'budi@example.com');

      expect(await viewModel.sendResetLink(), isTrue);
      expect(repository.lastResetEmail, 'budi@example.com');
      expect(viewModel.isSending, isFalse);
    });

    test('kegagalan pengiriman tautan reset memberi pesan kesalahan', () async {
      repository.resetResult = false;
      await viewModel.load();

      expect(await viewModel.sendResetLink(), isFalse);
      expect(viewModel.errorMessage, isNotNull);
    });
  });

  group('NewPasswordViewModel', () {
    late _FakeProfileRepository repository;
    late NewPasswordViewModel viewModel;

    setUp(() {
      repository = _FakeProfileRepository();
      viewModel = NewPasswordViewModel(
        ResetPassword(repository),
        SignOut(repository),
      )..email = 'budi@example.com';
    });

    tearDown(() => viewModel.dispose());

    test('save menolak kata sandi tidak valid', () async {
      viewModel.passwordController.text = 'pendek';
      viewModel.confirmationController.text = 'pendek';

      expect(await viewModel.save(), isFalse);
      expect(viewModel.errorMessage, contains('minimal 8 karakter'));
      expect(repository.lastNewPassword, isNull);
    });

    test('save menolak konfirmasi yang berbeda', () async {
      viewModel.passwordController.text = 'jeruk12345';
      viewModel.confirmationController.text = 'jeruk54321';

      expect(await viewModel.save(), isFalse);
      expect(viewModel.errorMessage, contains('tidak cocok'));
      expect(repository.lastNewPassword, isNull);
    });

    test('save menyimpan kata sandi baru lalu mengakhiri sesi', () async {
      viewModel.passwordController.text = 'jeruk12345';
      viewModel.confirmationController.text = 'jeruk12345';

      expect(await viewModel.save(), isTrue);

      expect(repository.lastResetPasswordEmail, 'budi@example.com');
      expect(repository.lastNewPassword, 'jeruk12345');
      expect(repository.didSignOut, isTrue);
      expect(viewModel.isSaving, isFalse);
      expect(viewModel.errorMessage, isNull);
    });

    test('save memberi pesan bila penyimpanan gagal', () async {
      repository.resetPasswordResult = false;
      viewModel.passwordController.text = 'jeruk12345';
      viewModel.confirmationController.text = 'jeruk12345';

      expect(await viewModel.save(), isFalse);
      expect(viewModel.errorMessage, isNotNull);
      expect(repository.didSignOut, isFalse);
    });

    test('togglePasswordVisibility mengubah mode obscure', () {
      expect(viewModel.obscurePassword, isTrue);
      viewModel.togglePasswordVisibility();
      expect(viewModel.obscurePassword, isFalse);
    });
  });

  group('HelpCenterViewModel', () {
    late _FakeProfileRepository repository;
    late HelpCenterViewModel viewModel;

    setUp(() {
      repository = _FakeProfileRepository();
      viewModel = HelpCenterViewModel(GetHelpCenter(repository));
    });

    tearDown(() => viewModel.dispose());

    test('load memuat kontak dan FAQ lalu mengakhiri loading', () async {
      expect(viewModel.isLoading, isFalse);

      final future = viewModel.load();
      expect(viewModel.isLoading, isTrue);
      await future;

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.helpCenter, isNotNull);
      expect(viewModel.helpCenter!.contacts, hasLength(1));
      expect(viewModel.helpCenter!.faqs, hasLength(2));
      expect(viewModel.helpCenter!.topics, [
        'Kunjungan & Jadwal',
        'Pembayaran',
      ]);
      expect(
        viewModel.helpCenter!.faqsByCategory['Pembayaran']!.single.id,
        'faq-2',
      );
    });

    test('load menampilkan pesan bila gagal memuat', () async {
      repository.helpCenterShouldFail = true;

      await viewModel.load();

      expect(viewModel.helpCenter, isNull);
      expect(viewModel.errorMessage, isNotNull);
    });

    test('toggleFaq membuka satu FAQ dan menutupnya kembali', () {
      expect(viewModel.isExpanded('faq-1'), isFalse);

      viewModel.toggleFaq('faq-1');
      expect(viewModel.isExpanded('faq-1'), isTrue);
      expect(viewModel.isExpanded('faq-2'), isFalse);

      viewModel.toggleFaq('faq-2');
      expect(viewModel.isExpanded('faq-1'), isFalse);
      expect(viewModel.isExpanded('faq-2'), isTrue);

      viewModel.toggleFaq('faq-2');
      expect(viewModel.isExpanded('faq-2'), isFalse);
    });
  });

  group('ResetPasswordSuccessViewModel', () {
    late _FakeProfileRepository repository;
    late ResetPasswordSuccessViewModel viewModel;

    setUp(() {
      repository = _FakeProfileRepository();
      viewModel = ResetPasswordSuccessViewModel(SignOut(repository));
    });

    tearDown(() => viewModel.dispose());

    test('signOut berhasil mengakhiri sesi', () async {
      expect(await viewModel.signOut(), isTrue);
      expect(repository.didSignOut, isTrue);
    });

    test('signOut gagal memberi pesan kesalahan', () async {
      repository.signOutShouldFail = true;

      expect(await viewModel.signOut(), isFalse);
      expect(viewModel.errorMessage, isNotNull);
    });
  });

  group('ProfileLocalDataSource', () {
    setUp(() => AuthService.instance.reset());
    tearDown(() => AuthService.instance.reset());

    test('signOut membersihkan cache agar akun berikutnya tidak memakai '
        'profil lama', () async {
      final auth = AuthService.instance
        ..currentUser = Account(
          id: 'a',
          fullName: 'Budi Santoso',
          email: 'budi@example.com',
          phone: '081234567890',
          createdAt: DateTime(2026, 1, 1),
        );
      final dataSource = ProfileLocalDataSource(auth);

      expect((await dataSource.getProfile()).fullName, 'Budi Santoso');

      await dataSource.signOut();
      auth.currentUser = Account(
        id: 'b',
        fullName: 'Siti Aminah',
        email: 'siti@example.com',
        phone: '081987654321',
        createdAt: DateTime(2026, 2, 14),
      );

      final nextProfile = await dataSource.getProfile();
      expect(nextProfile.fullName, 'Siti Aminah');
      expect(nextProfile.email, 'siti@example.com');
    });
  });
}
