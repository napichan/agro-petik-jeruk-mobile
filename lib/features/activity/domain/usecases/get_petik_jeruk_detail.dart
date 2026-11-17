import '../entities/petik_jeruk_detail.dart';
import '../repositories/petik_jeruk_repository.dart';

class GetPetikJerukDetail {
  const GetPetikJerukDetail(this._repository);

  final PetikJerukRepository _repository;

  Future<PetikJerukDetail> call() => _repository.getDetail();
}
