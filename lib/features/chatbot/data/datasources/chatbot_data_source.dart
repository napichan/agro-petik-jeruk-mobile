import '../../domain/entities/quick_reply.dart';
import '../models/chat_message_model.dart';

/// Kontrak sumber data percakapan asisten kebun.
abstract class ChatbotDataSource {
  Future<ChatMessageModel> getWelcomeMessage({required String userName});

  Future<QuickReplySet> getQuickReplies();

  Future<ChatReplyModel> sendMessage(String message);
}
