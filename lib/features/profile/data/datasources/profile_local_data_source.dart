import '../../../auth/data/datasources/auth_service.dart';
import '../../domain/entities/faq_item.dart';
import '../../domain/entities/help_center.dart';
import '../../domain/entities/profile_update.dart';
import '../../domain/entities/user_profile.dart';

abstract class ProfileDataSource {
  Future<UserProfile> getProfile();

  Future<UserProfile> updateProfile(ProfileUpdate update);

  Future<bool> requestPasswordReset(String email);

  Future<bool> resetPassword(String email, String newPassword);

  Future<HelpCenter> getHelpCenter();

  Future<void> signOut();
}

/// Sumber data dummy profil (in-memory).
///
/// Profil disimpan pada satu instance sehingga perubahan dari halaman Edit
/// Profil tetap terlihat saat kembali ke halaman Profile selama aplikasi
/// berjalan.
class ProfileLocalDataSource implements ProfileDataSource {
  ProfileLocalDataSource(this._authService);

  final AuthService _authService;

  UserProfile? _profile;

  static const Duration _readDelay = Duration(milliseconds: 250);
  static const Duration _saveDelay = Duration(milliseconds: 700);
  static const Duration _resetDelay = Duration(milliseconds: 1200);
  static const Duration _helpDelay = Duration(milliseconds: 350);

  static final DateTime _dummyMemberSince = DateTime(2026, 3, 1);
  static final DateTime _dummyBirthDate = DateTime(1998, 10, 14);

  @override
  Future<UserProfile> getProfile() async {
    if (_profile != null) return _profile!;
    await Future<void>.delayed(_readDelay);
    return _profile = _buildInitialProfile();
  }

  @override
  Future<UserProfile> updateProfile(ProfileUpdate update) async {
    await Future<void>.delayed(_saveDelay);

    final current = _profile ?? await getProfile();
    final updated = UserProfile(
      fullName: update.fullName.trim(),
      email: update.email.trim().toLowerCase(),
      phone: update.phone.trim(),
      memberLabel: current.memberLabel,
      stats: current.stats,
      birthDate: update.birthDate ?? current.birthDate,
      memberSince: current.memberSince,
      photoBytes: update.photoBytes ?? current.photoBytes,
      passwordUpdatedLabel: current.passwordUpdatedLabel,
    );

    return _profile = updated;
  }

  @override
  Future<bool> requestPasswordReset(String email) async {
    await Future<void>.delayed(_resetDelay);

    // Simulasi kegagalan sederhana: email harus berbentuk alamat email valid.
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email.trim());
  }

  @override
  Future<bool> resetPassword(String email, String newPassword) async {
    await Future<void>.delayed(_resetDelay);

    final validEmail = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email.trim());
    final validPassword =
        newPassword.length >= 8 &&
        RegExp(r'[A-Za-z]').hasMatch(newPassword) &&
        RegExp(r'[0-9]').hasMatch(newPassword);

    if (!validEmail || !validPassword) return false;

    // Kata sandi baru tersimpan pada simulasi ini: perbarui keterangan
    // "terakhir diubah" agar halaman Edit Profil menampilkan data terkini.
    final current = _profile;
    if (current != null) {
      _profile = UserProfile(
        fullName: current.fullName,
        email: current.email,
        phone: current.phone,
        memberLabel: current.memberLabel,
        stats: current.stats,
        birthDate: current.birthDate,
        memberSince: current.memberSince,
        photoBytes: current.photoBytes,
        passwordUpdatedLabel: 'Diubah hari ini',
      );
    }

    return true;
  }

  @override
  Future<HelpCenter> getHelpCenter() async {
    await Future<void>.delayed(_helpDelay);
    return _helpCenter;
  }

  @override
  Future<void> signOut() async {
    // Hapus cache agar akun berikutnya tidak mewarisi data profil lama.
    _profile = null;
    _authService.logout();
  }

  /// Data dummy Pusat Bantuan: kontak pengelola + FAQ per kategori.
  static const HelpCenter _helpCenter = HelpCenter(
    contacts: [
      HelpContact(
        channel: HelpChannel.whatsapp,
        title: 'WhatsApp Pengelola',
        subtitle: 'Respon cepat < 10 mnt',
        description:
            'Chat langsung pengelola kebun untuk pertanyaan cepat seputar '
            'jadwal kunjungan, tiket, dan pembayaran.',
        number: '+62 812-3456-7890',
      ),
      HelpContact(
        channel: HelpChannel.callCenter,
        title: 'Loket & Call Center',
        subtitle: '08.00 - 16.00 WIB',
        description:
            'Hubungi petugas loket untuk bantuan reservasi rombongan atau '
            'kendala selama berada di kebun.',
        number: '(0263) 123-456',
      ),
    ],
    faqs: [
      FaqItem(
        id: 'faq-jadwal',
        category: 'Kunjungan & Jadwal',
        question: 'Bagaimana cara reschedule tanggal kunjungan?',
        answer:
            'Ajukan perubahan tanggal paling lambat 1 hari sebelum jadwal '
            'kunjungan melalui WhatsApp pengelola. Sertakan kode tiket dan '
            'tanggal pengganti yang diinginkan. Perubahan gratis satu kali.',
      ),
      FaqItem(
        id: 'faq-tiket-hari-lain',
        category: 'Kunjungan & Jadwal',
        question: 'Apakah tiket bisa dipakai di hari lain?',
        answer:
            'Tiket berlaku hanya pada tanggal yang tertera. Jika berhalangan '
            'hadir, ajukan reschedule sebelum tanggal kunjungan agar tiket '
            'tetap bisa digunakan.',
      ),
      FaqItem(
        id: 'faq-makan-sepuasnya',
        category: 'Peraturan Kebun',
        question: 'Apakah tiket sudah termasuk makan jeruk sepuasnya?',
        answer:
            'Tiket kunjungan sudah termasuk memetik dan menyantap jeruk di '
            'area petik. Jeruk yang dibawa pulang dihitung terpisah sesuai '
            'berat panen.',
      ),
      FaqItem(
        id: 'faq-anak',
        category: 'Peraturan Kebun',
        question: 'Apakah anak kecil boleh ikut memetik jeruk?',
        answer:
            'Boleh. Anak usia di bawah 5 tahun gratis dan wajib didampingi '
            'orang tua. Gunting petik hanya diberikan kepada pengunjung usia '
            'di atas 10 tahun demi keamanan.',
      ),
      FaqItem(
        id: 'faq-pembayaran',
        category: 'Pembayaran',
        question: 'Metode pembayaran apa saja yang diterima?',
        answer:
            'Kami menerima transfer bank, QRIS, kartu debit/kredit, dan tunai '
            'di loket. Untuk rombongan di atas 20 orang, pembayaran dapat '
            'dilakukan dengan DP 50% saat reservasi.',
      ),
      FaqItem(
        id: 'faq-pembayaran-lokasi',
        category: 'Pembayaran',
        question: 'Apakah pembayaran bisa dilakukan di lokasi?',
        answer:
            'Bisa, selama kuota kunjungan pada hari tersebut masih tersedia. '
            'Loket menerima tunai, QRIS, dan kartu debit/kredit pada pukul '
            '08.00 - 16.00 WIB.',
      ),
      FaqItem(
        id: 'faq-parkir',
        category: 'Akses & Lokasi',
        question: 'Bagaimana akses dan parkir untuk bus rombongan?',
        answer:
            'Lahan parkir bus belum tersedia di area kebun. Bus berhenti di '
            'titik jemput yang disediakan, lalu pengunjung dijemput shuttle '
            'menuju pintu masuk kebun. Informasikan jumlah rombongan ke '
            'pengelola agar jadwal shuttle disiapkan.',
      ),
      FaqItem(
        id: 'faq-refund',
        category: 'Pembatalan & Refund',
        question: 'Bagaimana kebijakan pembatalan tiket?',
        answer:
            'Pembatalan lebih dari 3 hari sebelum kunjungan dikembalikan 80% '
            'dari total pembayaran. Pembatalan kurang dari 3 hari tidak dapat '
            'direfund, tetapi tiket bisa dijadwalkan ulang.',
      ),
    ],
  );

  UserProfile _buildInitialProfile() {
    final account = _authService.currentUser;

    return UserProfile(
      fullName: account?.fullName ?? 'Haura Jasmine',
      email: account?.email ?? 'jasmine29@gmail.com',
      phone: account?.phone ?? '+62 812-3456-7890',
      memberLabel: 'Member Setia',
      memberSince: account?.createdAt ?? _dummyMemberSince,
      birthDate: _dummyBirthDate,
      stats: const [
        ProfileStat(label: 'Tiket Aktif', value: '1'),
        ProfileStat(label: 'Kunjungan', value: '4'),
        ProfileStat(
          label: 'Poin Kebun',
          value: '350',
          isHighlighted: true,
        ),
      ],
    );
  }
}
