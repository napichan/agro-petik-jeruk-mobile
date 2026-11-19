import '../entities/help_center.dart';
import '../entities/profile_update.dart';
import '../entities/user_profile.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile();

  /// Menyimpan perubahan profil dan mengembalikan profil terbaru.
  Future<UserProfile> updateProfile(ProfileUpdate update);

  /// Mensimulasikan pengiriman tautan reset kata sandi ke [email].
  /// Mengembalikan `true` bila pengiriman berhasil.
  Future<bool> requestPasswordReset(String email);

  /// Menyimpan kata sandi baru untuk [email] setelah tautan reset dibuka.
  /// Mengembalikan `true` bila kata sandi berhasil diperbarui.
  Future<bool> resetPassword(String email, String newPassword);

  /// Kontak pengelola dan daftar FAQ untuk halaman Pusat Bantuan.
  Future<HelpCenter> getHelpCenter();

  /// Mengakhiri sesi pengguna yang sedang aktif.
  Future<void> signOut();
}
