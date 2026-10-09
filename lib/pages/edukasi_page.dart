import 'package:flutter/material.dart';

import 'detail_aktivitas_template.dart';

/// Halaman detail aktivitas "Edukasi Budidaya Tani".
class EdukasiPage extends StatelessWidget {
  const EdukasiPage({super.key});

  static const DetailAktivitasData _data = DetailAktivitasData(
    nama: 'Edukasi Budidaya Tani',
    alamat:
        'Jl. Watu Gede, RT03/RW.2, Selorejo Kec. Dau, Kabupaten Malang',
    durasi: '2 jam',
    harga: 35000,
    rating: '4.9',
    jumlahUlasan: '950',
    aktivitas: [
      (
        ikon: Icons.school,
        teks: 'Belajar budidaya jeruk dari petani berpengalaman',
      ),
      (
        ikon: Icons.grass,
        teks: 'Demo penanaman & perawatan pohon jeruk',
      ),
      (
        ikon: Icons.quiz,
        teks: 'Sesi tanya jawab seputar pertanian jeruk',
      ),
      (
        ikon: Icons.emoji_events,
        teks: 'Sertifikat kunjungan edukasi untuk kelompok',
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
    reviewer: 'Budi Santoso',
    reviewTeks:
        '"Anak-anak sangat antusias belajar budidaya jeruk. '
        'Petaninya ramah dan penjelasannya mudah dipahami '
        'oleh keluarga maupun pelajar."',
  );

  @override
  Widget build(BuildContext context) {
    return const DetailAktivitasTemplate(data: _data);
  }
}
