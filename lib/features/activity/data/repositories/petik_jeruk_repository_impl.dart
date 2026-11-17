import '../../domain/entities/petik_jeruk_detail.dart';
import '../../domain/repositories/petik_jeruk_repository.dart';
import '../datasources/petik_jeruk_local_data_source.dart';

class PetikJerukRepositoryImpl implements PetikJerukRepository {
  const PetikJerukRepositoryImpl(this._dataSource);

  final PetikJerukDataSource _dataSource;

  @override
  Future<PetikJerukDetail> getDetail() => _dataSource.getDetail();
}
