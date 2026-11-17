import '../../../auth/data/datasources/auth_service.dart';
import '../../domain/entities/user_profile.dart';

abstract class ProfileDataSource {
  Future<UserProfile> getProfile();
}

/// Membaca akun aktif dari [AuthService] dan menambahkan statistik dummy.
class ProfileLocalDataSource implements ProfileDataSource {
  const ProfileLocalDataSource(this._authService);

  final AuthService _authService;

  @override
  Future<UserProfile> getProfile() async {
    final account = _authService.currentUser ??
        (_authService.accounts.isEmpty ? null : _authService.accounts.first);
    final fullName = account?.fullName ?? 'Budi Santoso';

    return UserProfile(
      fullName: fullName,
      email: account?.email ?? 'budi@example.com',
      phone: account?.phone ?? '081234567890',
      memberLabel: 'Member Setia',
      stats: const [
        ProfileStat(label: 'Tiket Aktif', value: '1'),
        ProfileStat(label: 'Kunjungan', value: '4'),
        ProfileStat(label: 'Poin Kebun', value: '350', isHighlighted: true),
      ],
    );
  }
}
