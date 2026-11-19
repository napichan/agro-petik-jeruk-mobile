import 'package:flutter_agrowisatajeruk/core/models/activity_item.dart';
import 'package:flutter_agrowisatajeruk/core/models/facility.dart';
import '../models/activity_detail_model.dart';

abstract class ActivityDetailDataSource {
  Future<ActivityDetailModel> getActivityDetail(String id);
}

/// Sumber data dummy (in-memory) untuk halaman detail wisata.
class ActivityDetailMockDataSource implements ActivityDetailDataSource {
  const ActivityDetailMockDataSource();

  static const String _defaultId = 'petik-jeruk-langsung';

  static const ActivityDetailModel _petikJerukLangsung = ActivityDetailModel(
    id: _defaultId,
    title: 'Petik Jeruk Langsung',
    address:
        'Jl. Watu Gede, RT.010/RW.2, Selorejo, Kec. Dau, '
        'Kabupaten Malang.',
    duration: '2 – 3 Jam',
    price: 20000,
    heroImage: 'assets/images/kebun_jeruk_solorejo.png',
    activities: [
      ActivityItem(
        text: 'Petik & makan jeruk segar sepuasnya di kebun',
        icon: ActivityIconType.check,
        tone: ActivityTone.green,
      ),
      ActivityItem(
        text: 'Peminjaman keranjang rotan & gunting petik',
        icon: ActivityIconType.scissors,
        tone: ActivityTone.salmon,
      ),
      ActivityItem(
        text: 'Akses jelajah kebun lereng 850 mdpl',
        icon: ActivityIconType.mountain,
        tone: ActivityTone.blue,
      ),
      ActivityItem(
        text: 'Didampingi pemandu petani lokal',
        icon: ActivityIconType.guide,
        tone: ActivityTone.lime,
      ),
    ],
    facilities: [
      Facility(label: 'Parkir', icon: FacilityIconType.parking),
      Facility(label: 'Toilet', icon: FacilityIconType.toilet),
      Facility(label: 'Gubuk', icon: FacilityIconType.hut),
      Facility(label: 'Toko', icon: FacilityIconType.store),
    ],
  );

  @override
  Future<ActivityDetailModel> getActivityDetail(String id) async {
    // Saat ini hanya satu aktivitas yang punya data dummy.
    return _petikJerukLangsung;
  }
}
