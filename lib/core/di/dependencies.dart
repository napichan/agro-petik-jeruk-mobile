import 'package:flutter_agrowisatajeruk/features/activity/data/datasources/petik_jeruk_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/activity/data/repositories/petik_jeruk_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/activity/domain/usecases/get_petik_jeruk_detail.dart';
import 'package:flutter_agrowisatajeruk/features/activity/presentation/viewmodels/petik_jeruk_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/auth/data/datasources/auth_service.dart';
import 'package:flutter_agrowisatajeruk/features/education/data/datasources/education_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/education/data/repositories/education_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/education/domain/entities/education_activity.dart';
import 'package:flutter_agrowisatajeruk/features/education/domain/usecases/get_education_activity.dart';
import 'package:flutter_agrowisatajeruk/features/education/presentation/viewmodels/education_activity_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/home/domain/usecases/get_home_content.dart';
import 'package:flutter_agrowisatajeruk/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/notification/data/datasources/notification_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/notification/domain/usecases/get_notifications.dart';
import 'package:flutter_agrowisatajeruk/features/notification/domain/usecases/mark_all_notifications_read.dart';
import 'package:flutter_agrowisatajeruk/features/notification/presentation/viewmodels/notification_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/profile/domain/usecases/get_profile.dart';
import 'package:flutter_agrowisatajeruk/features/profile/presentation/viewmodels/profile_view_model.dart';

/// Composition root sederhana (tanpa package tambahan).
///
/// Semua perakitan datasource -> repository -> usecase -> viewmodel
/// terpusat di sini agar layer presentasi tidak bergantung pada
/// implementasi konkret.
class AppDependencies {
  AppDependencies._();

  static final AppDependencies instance = AppDependencies._();

  final AuthService _authService = AuthService.instance;

  late final NotificationDataSource _notificationDataSource =
      NotificationLocalDataSource();

  HomeViewModel createHomeViewModel() {
    return HomeViewModel(
      GetHomeContent(
        HomeRepositoryImpl(HomeLocalDataSource(_authService)),
      ),
    );
  }

  EducationActivityViewModel createEducationActivityViewModel(
    EducationActivityType type,
  ) {
    return EducationActivityViewModel(
      GetEducationActivity(
        const EducationRepositoryImpl(EducationLocalDataSource()),
      ),
      type,
    );
  }

  PetikJerukViewModel createPetikJerukViewModel() {
    return PetikJerukViewModel(
      GetPetikJerukDetail(
        const PetikJerukRepositoryImpl(PetikJerukLocalDataSource()),
      ),
    );
  }

  NotificationViewModel createNotificationViewModel() {
    final repository = NotificationRepositoryImpl(_notificationDataSource);
    return NotificationViewModel(
      GetNotifications(repository),
      MarkAllNotificationsRead(repository),
    );
  }

  ProfileViewModel createProfileViewModel() {
    return ProfileViewModel(
      GetProfile(
        ProfileRepositoryImpl(ProfileLocalDataSource(_authService)),
      ),
    );
  }
}
