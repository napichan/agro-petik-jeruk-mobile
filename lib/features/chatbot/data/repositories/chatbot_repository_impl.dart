import '../../domain/entities/chat_message.dart';
import '../../domain/entities/quick_reply.dart';
import '../../domain/repositories/chatbot_repository.dart';
import '../datasources/chatbot_data_source.dart';

class ChatbotRepositoryImpl implements ChatbotRepository {
  const ChatbotRepositoryImpl(this._dataSource);

  final ChatbotDataSource _dataSource;

  @override
  Future<ChatMessage> getWelcomeMessage({required String userName}) async {
    final model = await _dataSource.getWelcomeMessage(userName: userName);
    return model.toEntity();
  }

  @override
  Future<QuickReplySet> getQuickReplies() => _dataSource.getQuickReplies();

  @override
  Future<ChatReply> sendMessage(String message) async {
    final model = await _dataSource.sendMessage(message);
    return model.toEntity();
  }
}
