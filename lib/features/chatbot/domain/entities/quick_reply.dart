/// Ikon kecil yang dipakai chip quick reply (dipetakan ke ikon Flutter di UI).
enum QuickReplyIcon { orange, sun, none }

/// Satu chip saran pertanyaan.
class QuickReply {
  const QuickReply({
    required this.id,
    required this.label,
    required this.prompt,
    this.icon = QuickReplyIcon.none,
  });

  final String id;
  final String label;

  /// Teks yang dikirim sebagai pesan pengguna saat chip ditekan.
  final String prompt;
  final QuickReplyIcon icon;
}

/// Dua kelompok quick reply: di bawah pesan pembuka dan di atas input.
class QuickReplySet {
  const QuickReplySet({
    required this.welcome,
    required this.input,
  });

  static const QuickReplySet empty = QuickReplySet(welcome: [], input: []);

  final List<QuickReply> welcome;
  final List<QuickReply> input;
}
