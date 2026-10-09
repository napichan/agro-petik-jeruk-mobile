import 'package:flutter/material.dart';

import 'detail_aktivitas_template.dart';

/// Halaman detail aktivitas "Penelitian Lapangan".
class PenelitianPage extends StatelessWidget {
  const PenelitianPage({super.key});

  static const DetailAktivitasData _data = DetailAktivitasData(
    nama: 'Penelitian Lapangan',
    alamat:
        'Jl. Watu Gede, RT03/RW.2, Selorejo Kec. Dau, Kabupaten Malang',
    durasi: '4 - 8 jam',
    harga: 200000,
    rating: '4.9',
    jumlahUlasan: '180',
    aktivitas: [
      (
        ikon: Icons.science,
        teks: 'Akses area kebun untuk pengambilan data',
      ),
      (
        ikon: Icons.biotech,
        teks: 'Pendampingan teknis oleh petugas kebun',
      ),
      (
        ikon: Icons.assignment,
        teks: 'Izin pengambilan sampel tanah & daun jeruk',
      ),
      (
        ikon: Icons.groups,
        teks: 'Ruang kerja sementara untuk tim peneliti',
      ),
    ],
    fasilitas: [
      (ikon: Icons.local_parking, label: 'Parkirr'),
      (ikon: Icons.wc, label: 'Toilet'),
      (ikon: Icons.cottage, label: 'Gubuk'),
      (ikon: Icons.storefront, label: 'Toko'),
    ],
    titikKumpulJudul: 'Pintu Masuk Utama (Blok A)',
    titikKumpulAlamat:
        'Agro Wisata Petik Jeruk, Desa Solorejo, Kec. Dau, Kota Malang',
    reviewer: 'Andi Pratama',
    reviewTeks:
        '"Fasilitas penelitian memadai dan petugas sangat kooperatif. '
        'Sampel yang diambil lengkap dengan pendampingan teknisnya."',
  );

  @override
  Widget build(BuildContext context) {
    return const DetailAktivitasTemplate(data: _data);
  }
}
