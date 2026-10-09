/// Data dummy aktivitas populer untuk halaman beranda.
class AktivitasPopuler {
  const AktivitasPopuler({
    required this.nama,
    required this.rating,
    required this.deskripsi,
    required this.harga,
    required this.image,
    this.chipLabel = '',
  });

  final String nama;
  final String rating;
  final String deskripsi;
  final int harga;
  final String image;
  final String chipLabel;
}

const List<AktivitasPopuler> daftarAktivitasPopuler = [
  AktivitasPopuler(
    nama: 'Petik Jeruk Langsung',
    rating: '4.7',
    deskripsi:
        'Bebas petik & makan sepuasnya langsung di Kebun keprok lereng sejuk Solorejo.',
    harga: 20000,
    image: 'assets/images/Kebun Jeruk Solorejo.png',
    chipLabel: 'Makan Sepuasnya',
  ),
  AktivitasPopuler(
    nama: 'Edukasi Wisata',
    rating: '4.8',
    deskripsi:
        'Belajar budidaya jeruk langsung dari petani berpengalaman, pulang 1 bibit.',
    harga: 35000,
    image: 'assets/images/edukasi.png',
    chipLabel: 'Bawa Bibit',
  ),
];
