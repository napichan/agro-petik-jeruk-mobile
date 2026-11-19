import '../../domain/entities/informasi_kebun.dart';
import '../../domain/repositories/informasi_repository.dart';
import '../datasources/informasi_local_data_source.dart';

class InformasiRepositoryImpl implements InformasiRepository {
  const InformasiRepositoryImpl(this._dataSource);

  final InformasiDataSource _dataSource;

  @override
  Future<InformasiKebun> getInformasiKebun() =>
      _dataSource.getInformasiKebun();
}
