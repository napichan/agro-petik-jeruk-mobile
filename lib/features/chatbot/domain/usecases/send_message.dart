import '../entities/chat_message.dart';
import '../repositories/chatbot_repository.dart';

/// Mengirim pertanyaan pengguna ke asisten kebun.
class SendMessage {
  const SendMessage(this._repository);

  final ChatbotRepository _repository;

  Future<ChatReply> call(String message) => _repository.sendMessage(message);
}
