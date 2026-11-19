import '../../domain/entities/help_center.dart';
import '../../domain/entities/profile_update.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._dataSource);

  final ProfileDataSource _dataSource;

  @override
  Future<UserProfile> getProfile() => _dataSource.getProfile();

  @override
  Future<UserProfile> updateProfile(ProfileUpdate update) =>
      _dataSource.updateProfile(update);

  @override
  Future<bool> requestPasswordReset(String email) =>
      _dataSource.requestPasswordReset(email);

  @override
  Future<bool> resetPassword(String email, String newPassword) =>
      _dataSource.resetPassword(email, newPassword);

  @override
  Future<HelpCenter> getHelpCenter() => _dataSource.getHelpCenter();

  @override
  Future<void> signOut() => _dataSource.signOut();
}
