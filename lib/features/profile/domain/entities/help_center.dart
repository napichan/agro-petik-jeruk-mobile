import 'faq_item.dart';

/// Kanal bantuan langsung yang tersedia di Pusat Bantuan.
enum HelpChannel { whatsapp, callCenter }

/// Kartu kontak pengelola pada halaman Pusat Bantuan.
class HelpContact {
  const HelpContact({
    required this.channel,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.number,
  });

  final HelpChannel channel;
  final String title;

  /// Keterangan singkat di bawah judul, mis. jam operasional.
  final String subtitle;
  final String description;

  /// Nomor WhatsApp atau telepon yang bisa dihubungi atau disalin.
  final String number;
}

/// Isi halaman Pusat Bantuan: kontak pengelola dan daftar FAQ.
class HelpCenter {
  const HelpCenter({required this.contacts, required this.faqs});

  final List<HelpContact> contacts;
  final List<FaqItem> faqs;

  /// Kategori unik sesuai urutan kemunculan FAQ.
  List<String> get topics {
    final result = <String>[];
    for (final faq in faqs) {
      if (!result.contains(faq.category)) result.add(faq.category);
    }
    return result;
  }

  /// FAQ yang sudah dikelompokkan per kategori, mengikuti urutan [topics].
  Map<String, List<FaqItem>> get faqsByCategory {
    return {
      for (final topic in topics)
        topic: [
          for (final faq in faqs)
            if (faq.category == topic) faq,
        ],
    };
  }
}
