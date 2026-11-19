import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_icons.dart';

import '../../domain/entities/petik_jeruk_detail.dart';

abstract class PetikJerukDataSource {
  Future<PetikJerukDetail> getDetail();
}

/// Sumber data dummy detail "Petik Jeruk Langsung" (in-memory).
class PetikJerukLocalDataSource implements PetikJerukDataSource {
  const PetikJerukLocalDataSource();

  @override
  Future<PetikJerukDetail> getDetail() async => _detail;

  static const PetikJerukDetail _detail = PetikJerukDetail(
    nama: 'Petik Jeruk Langsung',
    alamat:
        'Jl. Watu Gede, RT.010/RW.2, Selorejo, Kec. Dau, '
        'Kabupaten Malang.',
    durasi: '2 – 3 Jam',
    harga: 'Rp 20.000',
    rating: '4.7',
    jumlahUlasan: '1.2k',
    aktivitas: [
      PetikJerukAktivitas(
        ikon: AppIcons.check,
        teks: 'Petik & makan jeruk segar sepuasnya di kebun',
        latar: kActivityToneGreen,
      ),
      PetikJerukAktivitas(
        ikon: AppIcons.scissors,
        teks: 'Peminjaman keranjang rotan & gunting petik',
        latar: kActivityToneSalmon,
      ),
      PetikJerukAktivitas(
        ikon: AppIcons.mountain,
        teks: 'Akses jelajah kebun lereng 850 mdpl',
        latar: kActivityToneBlue,
      ),
      PetikJerukAktivitas(
        ikon: AppIcons.guide,
        teks: 'Didampingi pemandu petani lokal',
        latar: kActivityToneLime,
      ),
    ],
    fasilitas: [
      (ikon: AppIcons.car, label: 'Parkir'),
      (ikon: AppIcons.toilet, label: 'Toilet'),
      (ikon: AppIcons.hut, label: 'Gubuk'),
      (ikon: AppIcons.store, label: 'Toko'),
    ],
  );
}
