import 'package:flutter_agrowisatajeruk/features/chatbot/data/datasources/chatbot_mock_data_source.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/data/repositories/chatbot_repository_impl.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/entities/chat_message.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/usecases/get_quick_replies.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/usecases/get_welcome_message.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/domain/usecases/send_message.dart';
import 'package:flutter_agrowisatajeruk/features/chatbot/presentation/viewmodels/chatbot_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ChatbotViewModel viewModel;

  setUp(() {
    final repository = ChatbotRepositoryImpl(ChatbotMockDataSource());
    viewModel = ChatbotViewModel(
      GetWelcomeMessage(repository),
      GetQuickReplies(repository),
      SendMessage(repository),
      userName: 'Budi',
    );
  });

  tearDown(() => viewModel.dispose());

  test('pesan "manis" menghasilkan kartu rekomendasi', () async {
    await viewModel.load();
    expect(viewModel.messages, hasLength(1));
    expect(viewModel.messages.first.text, contains('Budi'));

    await viewModel.send(preset: 'Jeruk apa yang sedang manis?');

    expect(
      viewModel.messages.any(
        (message) => message.type == ChatMessageType.recommendation,
      ),
      isTrue,
    );
    expect(
      viewModel.messages.any((message) => message.type == ChatMessageType.tips),
      isTrue,
    );
    expect(viewModel.isTyping, isFalse);
  });

  test('pesan tidak dikenal menghasilkan jawaban default', () async {
    await viewModel.load();
    await viewModel.send(preset: 'Bagaimana resep nasi goreng?');

    final lastBot = viewModel.messages.last;
    expect(lastBot.sender, ChatSender.bot);
    expect(lastBot.text, contains('Maaf, saya belum paham'));
  });

  test('tombol kirim nonaktif saat teks kosong', () async {
    await viewModel.load();

    expect(viewModel.canSend, isFalse);

    viewModel.textController.text = '   ';
    expect(viewModel.canSend, isFalse);

    viewModel.textController.text = 'Harga jeruk berapa?';
    expect(viewModel.canSend, isTrue);
  });
}
