import 'dart:typed_data';

/// Satu kotak statistik pada kartu profil.
class ProfileStat {
  const ProfileStat({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });

  final String label;
  final String value;
  final bool isHighlighted;
}

const List<String> _monthShortNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

/// Data profil pengguna yang ditampilkan di halaman Profile.
class UserProfile {
  const UserProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.memberLabel,
    required this.stats,
    this.birthDate,
    this.memberSince,
    this.photoBytes,
    this.passwordUpdatedLabel = 'Terakhir diubah 3 bulan lalu',
  });

  final String fullName;
  final String email;
  final String phone;
  final String memberLabel;
  final List<ProfileStat> stats;

  /// Tanggal lahir pengguna (opsional pada data dummy).
  final DateTime? birthDate;

  /// Tanggal pengguna bergabung sebagai member.
  final DateTime? memberSince;

  /// Foto profil yang dipilih pengguna (null = tampilkan inisial).
  final Uint8List? photoBytes;

  /// Keterangan kapan kata sandi terakhir diubah.
  final String passwordUpdatedLabel;

  bool get hasPhoto => photoBytes != null;

  /// Inisial dua kata pertama nama, mis. "Budi Santoso" -> "BS".
  String get initials => initialsOf(fullName);

  /// Label tanggal lahir, mis. "14 Okt 1998".
  String get birthDateLabel {
    final date = birthDate;
    return date == null ? '-' : formatShortDate(date);
  }

  /// Format tanggal singkat Indonesia, mis. "14 Okt 1998".
  static String formatShortDate(DateTime date) {
    return '${date.day} ${_monthShortNames[date.month - 1]} ${date.year}';
  }

  /// Inisial dari sebuah nama, dipakai juga saat form belum disimpan.
  static String initialsOf(String name) {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty);
    if (words.isEmpty) return '?';
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  }

  /// Label keanggotaan, mis. "Sejak Mar 2026".
  String get memberSinceLabel {
    final date = memberSince;
    if (date == null) return '';
    return 'Sejak ${_monthShortNames[date.month - 1]} ${date.year}';
  }
}
