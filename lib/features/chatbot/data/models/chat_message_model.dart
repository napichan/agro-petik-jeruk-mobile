import '../../domain/entities/chat_message.dart';
import '../../domain/entities/quick_reply.dart';
import 'recommendation_model.dart';

/// Representasi satu pesan dari sumber data (mock/API).
class ChatMessageModel {
  const ChatMessageModel({
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
  final RecommendationModel? recommendation;
  final ChatAction? action;
  final DateTime? sentAt;

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      sender: sender,
      type: type,
      text: text,
      recommendation: recommendation?.toEntity(),
      action: action,
      sentAt: sentAt,
    );
  }
}

/// Balasan bot dari sumber data beserta quick reply konteks berikutnya.
class ChatReplyModel {
  const ChatReplyModel({
    required this.messages,
    required this.quickReplies,
  });

  final List<ChatMessageModel> messages;
  final List<QuickReply> quickReplies;

  ChatReply toEntity() {
    return ChatReply(
      messages: List<ChatMessage>.unmodifiable(
        messages.map((message) => message.toEntity()),
      ),
      quickReplies: List<QuickReply>.unmodifiable(quickReplies),
    );
  }
}
