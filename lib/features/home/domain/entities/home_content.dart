import 'popular_activity.dart';

/// Data yang dibutuhkan halaman beranda.
class HomeContent {
  const HomeContent({
    required this.userFirstName,
    required this.activities,
  });

  final String userFirstName;
  final List<PopularActivity> activities;
}
