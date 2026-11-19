/// Rekomendasi jeruk yang ditampilkan sebagai kartu di dalam chat.
class ChatRecommendation {
  const ChatRecommendation({
    required this.id,
    required this.name,
    required this.sector,
    required this.grade,
    required this.pricePerKg,
    required this.brix,
    required this.readyPercent,
    required this.description,
    required this.emoji,
  });

  final String id;
  final String name;

  /// Lokasi pohon, mis. "SEKTOR A-1".
  final String sector;
  final String grade;

  /// Harga per kilogram dalam rupiah.
  final int pricePerKg;

  /// Tingkat kemanisan (derajat Brix).
  final double brix;

  /// Persentase buah yang siap petik.
  final int readyPercent;
  final String description;
  final String emoji;

  String get priceLabel {
    final digits = pricePerKg.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) buffer.write('.');
    }
    return 'Rp $buffer';
  }

  String get brixLabel => 'Manis ${brix.toStringAsFixed(1)}° Brix';

  String get readyLabel => 'Siap Petik $readyPercent%';
}
