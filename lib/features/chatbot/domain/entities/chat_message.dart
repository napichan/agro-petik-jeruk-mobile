import 'chat_recommendation.dart';
import 'quick_reply.dart';

/// Pengirim pesan dalam percakapan.
enum ChatSender { user, bot }

/// Jenis isi pesan: teks biasa, kartu rekomendasi, atau kartu tips.
enum ChatMessageType { text, recommendation, tips }

/// Aksi tambahan pada balasan bot, mis. tombol menuju halaman tiket.
class ChatAction {
  const ChatAction({required this.label, required this.route});

  final String label;
  final String route;
}

/// Satu pesan dalam percakapan.
class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.sender,
    required this.type,
    this.text = '',
    this.recommendation,
    this.action,
    this.sentAt,
  });

  final String id;
  final ChatSender sender;
  final ChatMessageType type;
  final String text;
  final ChatRecommendation? recommendation;
  final ChatAction? action;
  final DateTime? sentAt;

  bool get isUser => sender == ChatSender.user;
}

/// Balasan bot beserta quick reply yang diperbarui sesuai konteks.
class ChatReply {
  const ChatReply({required this.messages, required this.quickReplies});

  final List<ChatMessage> messages;
  final List<QuickReply> quickReplies;
}
