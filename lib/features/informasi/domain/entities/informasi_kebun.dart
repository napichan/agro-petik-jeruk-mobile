/// Satu butir tata tertib kebun.
class AturanKebun {
  const AturanKebun({required this.judul, required this.deskripsi});

  final String judul;
  final String deskripsi;
}

/// Ringkasan operasional harian kebun.
class RingkasanOperasional {
  const RingkasanOperasional({
    required this.status,
    required this.jamOperasional,
    required this.catatanJam,
    required this.lokasi,
    required this.alamat,
    required this.harga,
    required this.satuanHarga,
    required this.catatanHarga,
  });

  final String status;
  final String jamOperasional;
  final String catatanJam;
  final String lokasi;
  final String alamat;
  final String harga;
  final String satuanHarga;
  final String catatanHarga;
}

/// Konten halaman Informasi: syarat & ketentuan kunjungan.
class InformasiKebun {
  const InformasiKebun({
    required this.lokasi,
    required this.judul,
    required this.pengantar,
    required this.ringkasan,
    required this.aturan,
  });

  final String lokasi;
  final String judul;
  final String pengantar;
  final RingkasanOperasional ringkasan;
  final List<AturanKebun> aturan;
}
