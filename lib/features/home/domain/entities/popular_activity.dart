/// Satu aktivitas populer yang ditampilkan di beranda.
class PopularActivity {
  const PopularActivity({
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
