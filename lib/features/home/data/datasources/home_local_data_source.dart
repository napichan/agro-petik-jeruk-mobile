import '../../../auth/data/datasources/auth_data_source.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/entities/popular_activity.dart';

abstract class HomeDataSource {
  Future<HomeContent> getHomeContent();
}

/// Sumber data dummy beranda (in-memory).
class HomeLocalDataSource implements HomeDataSource {
  const HomeLocalDataSource(this._authDataSource);

  final AuthDataSource _authDataSource;

  static const String _fallbackFirstName = 'Budi';

  static const List<PopularActivity> _activities = [
    PopularActivity(
      nama: 'Petik Jeruk Langsung',
      rating: '4.7',
      deskripsi:
          'Bebas petik & makan sepuasnya langsung di Kebun keprok lereng sejuk Solorejo.',
      harga: 20000,
      image: 'assets/images/kebun_jeruk_solorejo.png',
      chipLabel: 'Makan Sepuasnya',
    ),
    PopularActivity(
      nama: 'Edukasi Wisata',
      rating: '4.8',
      deskripsi:
          'Belajar budidaya jeruk langsung dari petani berpengalaman, pulang 1 bibit.',
      harga: 35000,
      image: 'assets/images/edukasi.png',
      chipLabel: 'Bawa Bibit',
    ),
  ];

  @override
  Future<HomeContent> getHomeContent() async {
    return HomeContent(
      userFirstName: _authDataSource.currentUser?.firstName ?? _fallbackFirstName,
      activities: _activities,
    );
  }
}
