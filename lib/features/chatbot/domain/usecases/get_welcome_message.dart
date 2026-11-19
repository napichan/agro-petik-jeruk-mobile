import '../entities/chat_message.dart';
import '../repositories/chatbot_repository.dart';

/// Mengambil pesan pembuka asisten untuk pengguna yang sedang login.
class GetWelcomeMessage {
  const GetWelcomeMessage(this._repository);

  final ChatbotRepository _repository;

  Future<ChatMessage> call({required String userName}) {
    return _repository.getWelcomeMessage(userName: userName);
  }
}
