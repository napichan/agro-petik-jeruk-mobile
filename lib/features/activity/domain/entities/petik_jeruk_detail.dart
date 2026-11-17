import 'package:flutter/material.dart';

/// Satu baris daftar "Aktivitas" pada detail petik jeruk.
class PetikJerukAktivitas {
  const PetikJerukAktivitas(this.ikon, this.teks, this.latar, this.warnaIkon);

  final String ikon;
  final String teks;
  final Color latar;
  final Color warnaIkon;
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
  final List<({String ikon, String label})> fasilitas;
}
