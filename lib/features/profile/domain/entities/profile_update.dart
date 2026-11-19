import 'dart:typed_data';

/// Perubahan data profil yang dikirim dari halaman Edit Profil.
class ProfileUpdate {
  const ProfileUpdate({
    required this.fullName,
    required this.email,
    required this.phone,
    this.birthDate,
    this.photoBytes,
  });

  final String fullName;
  final String email;
  final String phone;
  final DateTime? birthDate;

  /// Foto baru yang dipilih pengguna. `null` berarti foto lama dipertahankan.
  final Uint8List? photoBytes;
}
