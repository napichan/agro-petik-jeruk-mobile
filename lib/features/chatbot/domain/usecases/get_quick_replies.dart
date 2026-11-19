import '../entities/quick_reply.dart';
import '../repositories/chatbot_repository.dart';

/// Mengambil saran pertanyaan awal dan saran di atas kolom input.
class GetQuickReplies {
  const GetQuickReplies(this._repository);

  final ChatbotRepository _repository;

  Future<QuickReplySet> call() => _repository.getQuickReplies();
}
