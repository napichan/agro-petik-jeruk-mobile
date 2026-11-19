/// Satu pertanyaan yang sering diajukan pada halaman Pusat Bantuan.
class FaqItem {
  const FaqItem({
    required this.id,
    required this.category,
    required this.question,
    required this.answer,
  });

  final String id;

  /// Kategori untuk mengelompokkan pertanyaan pada halaman.
  final String category;

  final String question;
  final String answer;
}
