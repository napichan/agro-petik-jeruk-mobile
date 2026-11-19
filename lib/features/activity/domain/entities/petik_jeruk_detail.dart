import 'package:flutter/material.dart';

/// Satu baris daftar "Aktivitas" pada detail petik jeruk.
class PetikJerukAktivitas {
  const PetikJerukAktivitas({
    required this.ikon,
    required this.teks,
    required this.latar,
  });

  /// Path aset SVG ikon aktivitas (sudah memuat lingkaran latar sendiri).
  final String ikon;

  final String teks;

  /// Warna lingkaran di belakang ikon.
  final Color latar;
}

/// Data detail aktivitas "Petik Jeruk Langsung".
class PetikJerukDetail {
  const PetikJerukDetail({
    required this.nama,
    required this.alamat,
    required this.durasi,
    required this.harga,
    required this.rating,
    required this.jumlahUlasan,
    required this.aktivitas,
    required this.fasilitas,
  });

  final String nama;
  final String alamat;
  final String durasi;
  final String harga;
  final String rating;
  final String jumlahUlasan;
  final List<PetikJerukAktivitas> aktivitas;

  /// Path aset SVG ikon fasilitas + labelnya.
  final List<({String ikon, String label})> fasilitas;
}
