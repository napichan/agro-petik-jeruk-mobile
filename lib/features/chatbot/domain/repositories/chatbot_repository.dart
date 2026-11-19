import '../entities/chat_message.dart';
import '../entities/quick_reply.dart';

/// Kontrak sumber percakapan asisten kebun.
abstract class ChatbotRepository {
  Future<ChatMessage> getWelcomeMessage({required String userName});

  Future<QuickReplySet> getQuickReplies();

  /// Mengirim pesan pengguna dan mengembalikan balasan bot.
  Future<ChatReply> sendMessage(String message);
}
