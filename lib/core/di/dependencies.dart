import 'package:flutter_agrowisatajeruk/features/activity/data/datasources/activity_detail_mock_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/activity/data/datasources/petik_jeruk_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/activity/data/repositories/activity_detail_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/activity/data/repositories/petik_jeruk_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/activity/domain/usecases/get_activity_detail.dart';
import 'package:flutter_agrowisatajeruk/features/activity/domain/usecases/get_petik_jeruk_detail.dart';
import 'package:flutter_agrowisatajeruk/features/activity/presentation/viewmodels/detail_wisata_viewmodel.dart';
import 'package:flutter_agrowisatajeruk/features/activity/presentation/viewmodels/petik_jeruk_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/auth/data/datasources/auth_service.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/data/datasources/chatbot_mock_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/data/repositories/chatbot_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/usecases/get_quick_replies.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/usecases/get_welcome_message.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/usecases/send_message.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/presentation/viewmodels/chatbot_viewmodel.dart';
import 'package:flutter_agrowisatajeruk/features/education/data/datasources/education_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/education/data/repositories/education_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/education/domain/entities/education_activity.dart';
import 'package:flutter_agrowisatajeruk/features/education/domain/usecases/get_education_activity.dart';
import 'package:flutter_agrowisatajeruk/features/education/presentation/viewmodels/education_activity_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/home/domain/usecases/get_home_content.dart';
import 'package:flutter_agrowisatajeruk/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/informasi/data/datasources/informasi_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/informasi/data/repositories/informasi_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/informasi/domain/usecases/get_informasi_kebun.dart';
import 'package:flutter_agrowisatajeruk/features/informasi/presentation/viewmodels/informasi_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/notification/data/datasources/notification_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/notification/data/repositories/notification_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/notification/domain/usecases/get_notifications.dart';
import 'package:flutter_agrowisatajeruk/features/notification/domain/usecases/mark_all_notifications_read.dart';
import 'package:flutter_agrowisatajeruk/features/notification/presentation/viewmodels/notification_view_model.dart';
import 'package:flutter_agrowisatajeruk/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/profile/data/repositories/profile_repository_impl.dart';
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

  /// Satu instance agar perubahan profil bertahan saat berpindah halaman.
  late final ProfileRepositoryImpl _profileRepository = ProfileRepositoryImpl(
    ProfileLocalDataSource(_authService),
  );

  HomeViewModel createHomeViewModel() {
    return HomeViewModel(
      GetHomeContent(HomeRepositoryImpl(HomeLocalDataSource(_authService))),
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

  DetailWisataViewModel createDetailWisataViewModel() {
    return DetailWisataViewModel(
      GetActivityDetail(
        const ActivityDetailRepositoryImpl(ActivityDetailMockDataSource()),
      ),
    );
  }

  PetikJerukViewModel createPetikJerukViewModel() {
    return PetikJerukViewModel(
      GetPetikJerukDetail(
        const PetikJerukRepositoryImpl(PetikJerukLocalDataSource()),
      ),
    );
  }

  InformasiViewModel createInformasiViewModel() {
    return InformasiViewModel(
      GetInformasiKebun(
        const InformasiRepositoryImpl(InformasiLocalDataSource()),
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
      GetProfile(_profileRepository),
      SignOut(_profileRepository),
    );
  }

  EditProfileViewModel createEditProfileViewModel() {
    return EditProfileViewModel(
      GetProfile(_profileRepository),
      UpdateProfile(_profileRepository),
    );
  }

  EditPasswordViewModel createEditPasswordViewModel() {
    return EditPasswordViewModel(
      GetProfile(_profileRepository),
      RequestPasswordReset(_profileRepository),
    );
  }

  NewPasswordViewModel createNewPasswordViewModel() {
    return NewPasswordViewModel(
      ResetPassword(_profileRepository),
      SignOut(_profileRepository),
    );
  }

  HelpCenterViewModel createHelpCenterViewModel() {
    return HelpCenterViewModel(GetHelpCenter(_profileRepository));
  }

  ResetPasswordSuccessViewModel createResetPasswordSuccessViewModel() {
    return ResetPasswordSuccessViewModel(SignOut(_profileRepository));
  }

  ChatbotViewModel createChatbotViewModel() {
    final repository = ChatbotRepositoryImpl(ChatbotMockDataSource());
    return ChatbotViewModel(
      GetWelcomeMessage(repository),
      GetQuickReplies(repository),
      SendMessage(repository),
      userName: _authService.currentUser?.firstName ?? 'Pengunjung',
    );
  }
}
