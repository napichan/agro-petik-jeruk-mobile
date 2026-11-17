import '../entities/home_content.dart';

abstract class HomeRepository {
  Future<HomeContent> getHomeContent();
}
