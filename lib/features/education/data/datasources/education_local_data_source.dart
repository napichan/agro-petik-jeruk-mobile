import 'package:flutter/material.dart';

import '../../domain/entities/education_activity.dart';

abstract class EducationDataSource {
  Future<EducationActivity> getActivity(EducationActivityType type);
}

/// Sumber data dummy aktivitas edukasi (in-memory).
class EducationLocalDataSource implements EducationDataSource {
  const EducationLocalDataSource();

  static const String _alamat =
      'Jl. Watu Gede, RT03/RW.2, Selorejo Kec. Dau, Kabupaten Malang';
  static const String _titikKumpulJudul = 'Pintu Masuk Utama (Blok A)';
  static const String _titikKumpulAlamat =
      'Agro Wisata Petik Jeruk, Desa Solorejo, Kec. Dau, Kota Malang';
  static const List<({IconData ikon, String label})> _fasilitas = [
    (ikon: Icons.local_parking, label: 'Parker'),
    (ikon: Icons.wc, label: 'Toilet'),
    (ikon: Icons.cottage, label: 'Gubuk'),
    (ikon: Icons.storefront, label: 'Toko'),
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
    nama: 'Edukasi Budidaya Tani',
    alamat: _alamat,
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
    fasilitas: _fasilitas,
    titikKumpulJudul: _titikKumpulJudul,
    titikKumpulAlamat: _titikKumpulAlamat,
    reviewer: 'Budi Santoso',
    reviewTeks:
        '"Anak-anak sangat antusias belajar budidaya jeruk. '
        'Petaninya ramah dan penjelasannya mudah dipahami '
        'oleh keluarga maupun pelajar."',
  );

  static const EducationActivity _wawancara = EducationActivity(
    nama: 'Wawancara Petani',
    alamat: _alamat,
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
    fasilitas: _fasilitas,
    titikKumpulJudul: _titikKumpulJudul,
    titikKumpulAlamat: _titikKumpulAlamat,
    reviewer: 'Siti Rahma',
    reviewTeks:
        '"Petani sangat terbuka dan komunikatif. Materi wawancara '
        'lengkap, cocok untuk keperluan penelitian maupun tugas kuliah."',
  );

  static const EducationActivity _penelitian = EducationActivity(
    nama: 'Penelitian Lapangan',
    alamat: _alamat,
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
    titikKumpulJudul: _titikKumpulJudul,
    titikKumpulAlamat: _titikKumpulAlamat,
    reviewer: 'Andi Pratama',
    reviewTeks:
        '"Fasilitas penelitian memadai dan petugas sangat kooperatif. '
        'Sampel yang diambil lengkap dengan pendampingan teknisnya."',
  );
}
