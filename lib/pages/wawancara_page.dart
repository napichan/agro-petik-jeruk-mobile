import 'package:flutter/material.dart';

import 'detail_aktivitas_template.dart';

/// Halaman detail aktivitas "Wawancara Petani".
class WawancaraPage extends StatelessWidget {
  const WawancaraPage({super.key});

  static const DetailAktivitasData _data = DetailAktivitasData(
    nama: 'Wawancara Petani',
    alamat:
        'Jl. Watu Gede, RT03/RW.2, Selorejo Kec. Dau, Kabupaten Malang',
    durasi: '1 - 2 jam',
    harga: 50000,
    rating: '4.9',
    jumlahUlasan: '420',
    aktivitas: [
      (
        ikon: Icons.record_voice_over,
        teks: 'Wawancara langsung dengan petani jeruk',
      ),
      (
        ikon: Icons.travel_explore,
        teks: 'Kunjungan lapangan ke area kebun jeruk',
      ),
      (
        ikon: Icons.menu_book,
        teks: 'Dokumentasi praktik budidaya & panen',
      ),
      (
        ikon: Icons.handshake,
        teks: 'Diskusi kelompok bersama pengelola kebun',
      ),
    ],
    fasilitas: [
      (ikon: Icons.local_parking, label: 'Parker'),
      (ikon: Icons.wc, label: 'Toilet'),
      (ikon: Icons.cottage, label: 'Gubuk'),
      (ikon: Icons.storefront, label: 'Toko'),
    ],
    titikKumpulJudul: 'Pintu Masuk Utama (Blok A)',
    titikKumpulAlamat:
        'Agro Wisata Petik Jeruk, Desa Solorejo, Kec. Dau, Kota Malang',
    reviewer: 'Siti Rahma',
    reviewTeks:
        '"Petani sangat terbuka dan komunikatif. Materi wawancara '
        'lengkap, cocok untuk keperluan penelitian maupun tugas kuliah."',
  );

  @override
  Widget build(BuildContext context) {
    return const DetailAktivitasTemplate(data: _data);
  }
}
