import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_agrowisatajeruk/features/activity/domain/entities/activity_detail.dart';
import 'package:flutter_agrowisatajeruk/features/activity/domain/repositories/activity_detail_repository.dart';
import 'package:flutter_agrowisatajeruk/features/activity/domain/usecases/get_activity_detail.dart';
import 'package:flutter_agrowisatajeruk/features/activity/presentation/viewmodels/detail_wisata_viewmodel.dart';

class _FakeActivityDetailRepository implements ActivityDetailRepository {
  _FakeActivityDetailRepository(this._future);

  final Future<ActivityDetail> _future;

  @override
  Future<ActivityDetail> getActivityDetail(String id) => _future;
}

const _detail = ActivityDetail(
  id: 'petik-jeruk-langsung',
  title: 'Petik Jeruk Langsung',
  address: 'Jl. Watu Gede, RT.010/RW.2, Selorejo, Kec. Dau, Kabupaten Malang.',
  duration: '2 – 3 Jam',
  price: 20000,
  heroImage: 'assets/images/kebun_jeruk_solorejo.png',
  activities: [],
  facilities: [],
);

void main() {
  group('DetailWisataViewModel', () {
    test('loading lalu data terisi setelah usecase selesai', () async {
      final completer = Completer<ActivityDetail>();
      final viewModel = DetailWisataViewModel(
        GetActivityDetail(_FakeActivityDetailRepository(completer.future)),
      );

      final loadFuture = viewModel.load('petik-jeruk-langsung');

      expect(viewModel.isLoading, isTrue);
      expect(viewModel.detail, isNull);
      expect(viewModel.errorMessage, isNull);

      completer.complete(_detail);
      await loadFuture;

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.detail, isNotNull);
      expect(viewModel.detail!.title, 'Petik Jeruk Langsung');
      expect(viewModel.errorMessage, isNull);
    });

    test('format harga tiket memakai pemisah ribuan rupiah', () async {
      final viewModel = DetailWisataViewModel(
        GetActivityDetail(_FakeActivityDetailRepository(Future.value(_detail))),
      );

      await viewModel.load('petik-jeruk-langsung');

      expect(viewModel.hargaFormatted, 'Rp 20.000');
    });
  });
}
