import '../entities/home_content.dart';
import '../repositories/home_repository.dart';

class GetHomeContent {
  const GetHomeContent(this._repository);

  final HomeRepository _repository;

  Future<HomeContent> call() => _repository.getHomeContent();
}
