import '../../domain/entities/informasi_kebun.dart';

abstract class InformasiDataSource {
  Future<InformasiKebun> getInformasiKebun();
}

/// Sumber data dummy konten Informasi (in-memory).
class InformasiLocalDataSource implements InformasiDataSource {
  const InformasiLocalDataSource();

  @override
  Future<InformasiKebun> getInformasiKebun() async => _informasiKebun;

  static const InformasiKebun _informasiKebun = InformasiKebun(
    lokasi: 'Agro Wisata Solorejo • Malang',
    judul: 'Panduan Petik & Kunjungan',
    pengantar:
        'Informasi operasional, ketentuan petik mandiri, serta tata tertib '
        'di area kebun jeruk keprok.',
    ringkasan: RingkasanOperasional(
      status: 'Buka Hari Ini',
      jamOperasional: '08.00 - 16.00 WIB',
      catatanJam: 'Loket penukaran gunting ditutup pukul 15.30 WIB',
      lokasi: 'Blok Jeruk Keprok 55',
      alamat: 'Desa Selorejo, Kec. Dau, Kab. Malang',
      harga: 'Rp 20.000',
      satuanHarga: '/ orang',
      catatanHarga: 'Makan sepuasnya langsung di dalam kebun',
    ),
    aturan: [
      AturanKebun(
        judul: 'Gunakan Gunting Khusus',
        deskripsi:
            'Gunakan gunting pinjaman agar ranting tidak patah. Gunting '
            'dikembalikan ke loket setelah selesai memetik.',
      ),
      AturanKebun(
        judul: 'Makan Sepuasnya',
        deskripsi:
            'Gratis makan di tempat. Jeruk bawaan pulang ditimbang '
            'Rp 15.000 - 20.000/kg.',
      ),
      AturanKebun(
        judul: 'Jaga Kebersihan',
        deskripsi:
            'Buang sampah kulit jeruk ke tong kompos di lorong kebun. '
            'Dilarang membuang sampah di area pohon.',
      ),
      AturanKebun(
        judul: 'Dampingi Anak-anak',
        deskripsi:
            'Jaga anak saat melintasi area kontur terasering kebun. '
            'Anak di bawah 12 tahun wajib didampingi orang tua.',
      ),
      AturanKebun(
        judul: 'Dilarang Merokok',
        deskripsi:
            'Merokok hanya diperbolehkan di area gazebo luar, bukan di '
            'dalam area kebun dan gubuk panen.',
      ),
    ],
  );
}
