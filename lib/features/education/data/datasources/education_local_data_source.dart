import 'package:flutter_agrowisatajeruk/core/models/activity_item.dart';
import 'package:flutter_agrowisatajeruk/core/models/facility.dart';

import '../../domain/entities/education_activity.dart';

abstract class EducationDataSource {
  Future<EducationActivity> getActivity(EducationActivityType type);
}

/// Sumber data dummy aktivitas edukasi (in-memory).
class EducationLocalDataSource implements EducationDataSource {
  const EducationLocalDataSource();

  static const String _alamat =
      'Jl. Watu Gede, RT.010/RW.2, Selorejo, Kec. Dau, Kabupaten Malang.';
  static const String _durasi = '2 – 3 Jam';
  static const int _hargaEdukasi = 35000;
  static const int _hargaWawancara = 50000;
  static const int _hargaPenelitian = 200000;

  static const List<Facility> _fasilitas = [
    Facility(label: 'Parkir', icon: FacilityIconType.parking),
    Facility(label: 'Toilet', icon: FacilityIconType.toilet),
    Facility(label: 'Gubuk', icon: FacilityIconType.hut),
    Facility(label: 'Toko', icon: FacilityIconType.store),
  ];

  @override
  Future<EducationActivity> getActivity(EducationActivityType type) async {
    return switch (type) {
      EducationActivityType.edukasi => _edukasi,
      EducationActivityType.wawancara => _wawancara,
      EducationActivityType.penelitian => _penelitian,
    };
  }

  static const EducationActivity _edukasi = EducationActivity(
    title: 'Edukasi Budidaya Jeruk',
    address: _alamat,
    duration: _durasi,
    price: _hargaEdukasi,
    heroImage: 'assets/images/budidaya.png',
    activities: [
      ActivityItem(
        text: 'Praktik teknik pemangkasan & okulasi dahan jeruk',
        icon: ActivityIconType.pruning,
        tone: ActivityTone.green,
      ),
      ActivityItem(
        text: 'Pengenalan varietas unggul & pemupukan organik',
        icon: ActivityIconType.recycle,
        tone: ActivityTone.salmon,
      ),
      ActivityItem(
        text: 'Cara perawatan tanaman & pencegahan hama buah',
        icon: ActivityIconType.pest,
        tone: ActivityTone.blue,
      ),
      ActivityItem(
        text: 'Praktik seleksi & petik buah jeruk siap panen',
        icon: ActivityIconType.basket,
        tone: ActivityTone.teal,
      ),
    ],
    facilities: _fasilitas,
  );

  static const EducationActivity _wawancara = EducationActivity(
    title: 'Wawancara Pengelola',
    address: _alamat,
    duration: _durasi,
    price: _hargaWawancara,
    heroImage: 'assets/images/wawancara.png',
    activities: [
      ActivityItem(
        text: 'Wawancara & tanya jawab langsung petani',
        icon: ActivityIconType.checkGreen,
        tone: ActivityTone.green,
      ),
      ActivityItem(
        text: 'Data budidaya & sejarah kebun',
        icon: ActivityIconType.book,
        tone: ActivityTone.yellow,
      ),
      ActivityItem(
        text: 'Izin dokumentasi foto/audio riset',
        icon: ActivityIconType.document,
        tone: ActivityTone.green,
      ),
    ],
    facilities: _fasilitas,
  );

  static const EducationActivity _penelitian = EducationActivity(
    title: 'Penelitian',
    address: _alamat,
    duration: _durasi,
    price: _hargaPenelitian,
    heroImage: 'assets/images/penelitian.png',
    activities: [
      ActivityItem(
        text: 'Pengambilan sampel daun, tanah & buah jeruk',
        icon: ActivityIconType.checkGreen,
        tone: ActivityTone.green,
      ),
      ActivityItem(
        text: 'Observasi agroklimat & data varietas jeruk',
        icon: ActivityIconType.observation,
        tone: ActivityTone.salmon,
      ),
      ActivityItem(
        text: 'Akses data plot riset, uji brix & lab kebun',
        icon: ActivityIconType.data,
        tone: ActivityTone.blue,
      ),
      ActivityItem(
        text: 'Didampingi teknisi kebun & izin riset resmi',
        icon: ActivityIconType.farmer,
        tone: ActivityTone.lime,
      ),
    ],
    facilities: _fasilitas,
  );
}
