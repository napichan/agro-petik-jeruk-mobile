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

/// Data profil pengguna yang ditampilkan di halaman Profile.
class UserProfile {
  const UserProfile({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.memberLabel,
    required this.stats,
  });

  final String fullName;
  final String email;
  final String phone;
  final String memberLabel;
  final List<ProfileStat> stats;

  /// Inisial dua kata pertama nama, mis. "Budi Santoso" -> "BS".
  String get initials {
    final words = fullName.trim().split(RegExp(r'\s+'));
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  }
}
