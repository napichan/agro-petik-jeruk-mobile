import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';

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
        'Jl. Watu Gede, RT 010/RW 2, Selorejo, Kec. Dau, Kabupaten Malang',
    durasi: '2 - 3 Jam',
    harga: 'Rp 20.000',
    rating: '4.7',
    jumlahUlasan: '1.2k',
    aktivitas: [
      PetikJerukAktivitas(
        Mdi.check_circle,
        'Petik & makan jeruk segar sepuasnya di kebun',
        kPrimaryGreen,
        Colors.white,
      ),
      PetikJerukAktivitas(
        Mdi.close_circle,
        'Peminjaman keranjang rotan & gunting petik',
        kPrimaryOrange,
        Colors.white,
      ),
      PetikJerukAktivitas(
        Mdi.terrain,
        'Akses jelajah kebun lereng 850 mdpl',
        Color(0xFFDBEAFE),
        Color(0xFF2563EB),
      ),
      PetikJerukAktivitas(
        Mdi.account_group,
        'Didampingi pemandu petani lokal',
        Color(0xFFDCFCE7),
        kPrimaryGreen,
      ),
    ],
    fasilitas: [
      (ikon: Mdi.parking, label: 'Parkir'),
      (ikon: Mdi.wc, label: 'Toilet'),
      (ikon: Mdi.home_outline, label: 'Glubuk'),
      (ikon: Mdi.storefront, label: 'Toko'),
    ],
  );
}
