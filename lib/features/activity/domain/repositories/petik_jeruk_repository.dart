import '../entities/petik_jeruk_detail.dart';

abstract class PetikJerukRepository {
  Future<PetikJerukDetail> getDetail();
}
