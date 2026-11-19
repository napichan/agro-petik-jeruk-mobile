import '../entities/informasi_kebun.dart';
import '../repositories/informasi_repository.dart';

class GetInformasiKebun {
  const GetInformasiKebun(this._repository);

  final InformasiRepository _repository;

  Future<InformasiKebun> call() => _repository.getInformasiKebun();
}
