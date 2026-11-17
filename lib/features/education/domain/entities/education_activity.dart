import 'package:flutter/material.dart';

/// Jenis aktivitas edukasi yang punya halaman detail.
enum EducationActivityType { edukasi, wawancara, penelitian }

/// Data lengkap satu aktivitas edukasi untuk halaman detail.
class EducationActivity {
  const EducationActivity({
    required this.nama,
    required this.alamat,
    required this.durasi,
    required this.harga,
    required this.rating,
    required this.jumlahUlasan,
    required this.aktivitas,
    required this.fasilitas,
    required this.titikKumpulJudul,
    required this.titikKumpulAlamat,
    required this.reviewer,
    required this.reviewTeks,
  });

  final String nama;
  final String alamat;
  final String durasi;
  final int harga;
  final String rating;
  final String jumlahUlasan;
  final List<({IconData ikon, String teks})> aktivitas;
  final List<({IconData ikon, String label})> fasilitas;
  final String titikKumpulJudul;
  final String titikKumpulAlamat;
  final String reviewer;
  final String reviewTeks;
}
