import '../entities/informasi_kebun.dart';

abstract class InformasiRepository {
  Future<InformasiKebun> getInformasiKebun();
}
