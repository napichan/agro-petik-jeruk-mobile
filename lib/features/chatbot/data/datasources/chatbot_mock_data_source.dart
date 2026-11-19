import 'dart:math';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/quick_reply.dart';
import '../models/chat_message_model.dart';
import '../models/recommendation_model.dart';
import 'chatbot_data_source.dart';

/// Sumber data dummy asisten kebun. Balasan dipilih dari kata kunci agar
/// percakapan terasa seperti AI tanpa backend.
class ChatbotMockDataSource implements ChatbotDataSource {
  ChatbotMockDataSource();

  static const Duration _typingDelay = Duration(milliseconds: 1200);

  final Random _random = Random();
  int _sequence = 0;

  static const String _tipsText =
      'Tips Mandor: Petik buah di bagian dahan bawah yang terkena sinar '
      'matahari pagi untuk rasa paling manis.';

  static const List<RecommendationModel> _recommendations = [
    RecommendationModel(
      id: 'jeruk-keprok-55',
      name: 'Jeruk Keprok 55',
      sector: 'SEKTOR A-1',
      grade: 'Grade Super A',
      pricePerKg: 28000,
      brix: 14.2,
      readyPercent: 95,
      description:
          'Kulit tipis, bulir sangat berair, rasa manis segar seimbang khas '
          'lereng Dau. Lokasi dekat Gazebo 2.',
      emoji: '🍊',
    ),
    RecommendationModel(
      id: 'jeruk-keprok-batu-55',
      name: 'Jeruk Keprok Batu 55',
      sector: 'SEKTOR B-2',
      grade: 'Grade A',
      pricePerKg: 26000,
      brix: 13.6,
      readyPercent: 88,
      description:
          'Aroma kuat dan rasa manis sedikit asam. Cocok untuk dibawa pulang, '
          'lokasi dekat area parkir utama.',
      emoji: '🍊',
    ),
    RecommendationModel(
      id: 'jeruk-siam-madu',
      name: 'Jeruk Siam Madu',
      sector: 'SEKTOR C-1',
      grade: 'Grade Super A',
      pricePerKg: 32000,
      brix: 15.1,
      readyPercent: 92,
      description:
          'Paling manis di kebun dengan bulir renyah. Banyak dicari pengunjung '
          'saat musim panen raya, dekat jalur edukasi.',
      emoji: '🍊',
    ),
    RecommendationModel(
      id: 'jeruk-pamelo',
      name: 'Jeruk Pamelo',
      sector: 'SEKTOR D-3',
      grade: 'Grade A',
      pricePerKg: 35000,
      brix: 11.8,
      readyPercent: 80,
      description:
          'Buah besar dengan daging tebal dan rasa manis ringan. Lokasi dekat '
          'gazebo keluarga dan area piknik.',
      emoji: '🍊',
    ),
  ];

  static const List<QuickReply> _welcomeReplies = [
    QuickReply(
      id: 'qr-welcome-manis',
      label: 'Jeruk apa yang sedang manis?',
      prompt: 'Jeruk apa yang sedang manis?',
      icon: QuickReplyIcon.orange,
    ),
    QuickReply(
      id: 'qr-welcome-waktu',
      label: 'Waktu petik terbaik?',
      prompt: 'Waktu petik terbaik?',
      icon: QuickReplyIcon.sun,
    ),
  ];

  static const List<QuickReply> _defaultReplies = [
    QuickReply(
      id: 'qr-harga',
      label: 'Berapa harga perkilonya?',
      prompt: 'Berapa harga perkilonya?',
    ),
    QuickReply(
      id: 'qr-pemandu',
      label: 'Ada pemandu petik?',
      prompt: 'Ada pemandu petik?',
    ),
    QuickReply(
      id: 'qr-jam',
      label: 'Jam operasional?',
      prompt: 'Jam operasional?',
    ),
  ];

  @override
  Future<QuickReplySet> getQuickReplies() async {
    return const QuickReplySet(
      welcome: _welcomeReplies,
      input: _defaultReplies,
    );
  }

  @override
  Future<ChatMessageModel> getWelcomeMessage({required String userName}) async {
    return ChatMessageModel(
      id: _nextId('welcome'),
      sender: ChatSender.bot,
      type: ChatMessageType.text,
      text:
          'Halo $userName! 🍊 Selamat datang di Kebun Agro Wisata Solorejo. '
          'Saya asisten pintar kebun yang siap membantu info varietas jeruk, '
          'panduan musim petik terbaik, hingga cek tiket & rute kebun.',
      sentAt: DateTime.now(),
    );
  }

  @override
  Future<ChatReplyModel> sendMessage(String message) async {
    await Future<void>.delayed(_typingDelay);

    final query = message.toLowerCase();
    bool has(List<String> keywords) =>
        keywords.any((keyword) => query.contains(keyword));

    if (has(const ['manis', 'paling'])) {
      return _recommendationReply();
    }
    if (has(const ['waktu', 'petik terbaik', 'kapan'])) {
      return _textReply(
        'Waktu terbaik memetik jeruk adalah pagi hari pukul 07.00–10.00 WIB, '
        'saat buah masih segar dan kadar gula alaminya optimal. Musim panen '
        'raya berlangsung Juli–September. Datang lebih awal agar kebun masih '
        'sejuk ya! 🍊',
        const [
          QuickReply(
            id: 'qr-jeruk-manis',
            label: 'Jeruk apa yang sedang manis?',
            prompt: 'Jeruk apa yang sedang manis?',
          ),
          QuickReply(
            id: 'qr-jam',
            label: 'Jam operasional?',
            prompt: 'Jam operasional?',
          ),
          QuickReply(
            id: 'qr-tiket',
            label: 'Pesan tiket',
            prompt: 'Pesan tiket',
          ),
        ],
      );
    }
    if (has(const ['harga', 'perkilo', 'per kg'])) {
      return _textReply(
        'Harga jeruk berkisar Rp 25.000–Rp 35.000 per kg tergantung varietas '
        'dan grade. Tiket petik langsung Rp 20.000 per orang dan sudah '
        'termasuk jeruk yang dipetik. Mau saya bantu pesan tiket?',
        const [
          QuickReply(
            id: 'qr-tiket',
            label: 'Pesan tiket',
            prompt: 'Pesan tiket',
          ),
          QuickReply(
            id: 'qr-waktu',
            label: 'Waktu petik terbaik?',
            prompt: 'Waktu petik terbaik?',
          ),
          QuickReply(
            id: 'qr-pemandu',
            label: 'Ada pemandu petik?',
            prompt: 'Ada pemandu petik?',
          ),
        ],
      );
    }
    if (has(const ['pemandu', 'guide', 'pandu'])) {
      return _textReply(
        'Tentu! Setiap kunjungan didampingi pemandu petik berpengalaman. '
        'Pemandu akan mengajarkan cara memetik yang benar agar dahan tetap '
        'sehat. Tidak ada biaya tambahan untuk pemandu.',
        const [
          QuickReply(
            id: 'qr-jam',
            label: 'Jam operasional?',
            prompt: 'Jam operasional?',
          ),
          QuickReply(
            id: 'qr-harga',
            label: 'Berapa harga perkilonya?',
            prompt: 'Berapa harga perkilonya?',
          ),
          QuickReply(
            id: 'qr-tiket',
            label: 'Pesan tiket',
            prompt: 'Pesan tiket',
          ),
        ],
      );
    }
    if (has(const ['jam', 'buka', 'operasional'])) {
      return _textReply(
        'Kebun Agro Wisata Solorejo buka setiap hari pukul 08.00–16.00 WIB. '
        'Waktu terbaik datang adalah pagi hari agar tidak terlalu panas. '
        'Sampai jumpa di kebun! 🌿',
        const [
          QuickReply(
            id: 'qr-waktu',
            label: 'Waktu petik terbaik?',
            prompt: 'Waktu petik terbaik?',
          ),
          QuickReply(
            id: 'qr-harga',
            label: 'Berapa harga perkilonya?',
            prompt: 'Berapa harga perkilonya?',
          ),
          QuickReply(
            id: 'qr-tiket',
            label: 'Pesan tiket',
            prompt: 'Pesan tiket',
          ),
        ],
      );
    }
    if (has(const ['tiket', 'pesan', 'booking'])) {
      return _textReply(
        'Tiket petik jeruk bisa dipesan langsung lewat aplikasi. Pilih '
        'tanggal kunjungan, jumlah orang, lalu selesaikan pembayaran. Tiket '
        'digital akan muncul di menu Tiket Saya.',
        const [
          QuickReply(
            id: 'qr-jam',
            label: 'Jam operasional?',
            prompt: 'Jam operasional?',
          ),
          QuickReply(
            id: 'qr-harga',
            label: 'Berapa harga perkilonya?',
            prompt: 'Berapa harga perkilonya?',
          ),
          QuickReply(
            id: 'qr-pemandu',
            label: 'Ada pemandu petik?',
            prompt: 'Ada pemandu petik?',
          ),
        ],
        action: const ChatAction(label: 'Pesan Tiket', route: '/pesan-tiket'),
      );
    }

    return _textReply(
      'Maaf, saya belum paham. Coba tanyakan soal varietas, harga, jam buka, '
      'atau waktu petik terbaik.',
      _defaultReplies,
    );
  }

  ChatReplyModel _recommendationReply() {
    final recommendation =
        _recommendations[_random.nextInt(_recommendations.length)];
    return ChatReplyModel(
      messages: [
        ChatMessageModel(
          id: _nextId('intro'),
          sender: ChatSender.bot,
          type: ChatMessageType.text,
          text:
              'Berdasarkan pantauan kondisi kebun hari ini, berikut '
              'rekomendasi terbaik:',
          sentAt: DateTime.now(),
        ),
        ChatMessageModel(
          id: _nextId('recommendation'),
          sender: ChatSender.bot,
          type: ChatMessageType.recommendation,
          recommendation: recommendation,
          sentAt: DateTime.now(),
        ),
        ChatMessageModel(
          id: _nextId('tips'),
          sender: ChatSender.bot,
          type: ChatMessageType.tips,
          text: _tipsText,
          sentAt: DateTime.now(),
        ),
      ],
      quickReplies: _defaultReplies,
    );
  }

  ChatReplyModel _textReply(
    String text,
    List<QuickReply> quickReplies, {
    ChatAction? action,
  }) {
    return ChatReplyModel(
      messages: [
        ChatMessageModel(
          id: _nextId('bot'),
          sender: ChatSender.bot,
          type: ChatMessageType.text,
          text: text,
          action: action,
          sentAt: DateTime.now(),
        ),
      ],
      quickReplies: quickReplies,
    );
  }

  String _nextId(String prefix) => '$prefix-${_sequence++}';
}
