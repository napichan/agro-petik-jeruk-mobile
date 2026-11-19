import 'package:flutter/material.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/quick_reply.dart';
import '../../domain/usecases/get_quick_replies.dart';
import '../../domain/usecases/get_welcome_message.dart';
import '../../domain/usecases/send_message.dart';

/// Mengatur percakapan asisten kebun: pesan, status mengetik, dan quick reply.
class ChatbotViewModel extends ChangeNotifier {
  ChatbotViewModel(
    this._getWelcomeMessage,
    this._getQuickReplies,
    this._sendMessage, {
    required this.userName,
  }) {
    _openedAt = DateTime.now();
    textController.addListener(_onTextChanged);
  }

  final GetWelcomeMessage _getWelcomeMessage;
  final GetQuickReplies _getQuickReplies;
  final SendMessage _sendMessage;

  final String userName;
  final TextEditingController textController = TextEditingController();

  late final DateTime _openedAt;
  final List<ChatMessage> _messages = [];
  QuickReplySet _quickReplySet = QuickReplySet.empty;

  bool _isLoading = true;
  bool _isTyping = false;
  String? _errorMessage;
  int _sequence = 0;

  List<ChatMessage> get messages => List<ChatMessage>.unmodifiable(_messages);
  List<QuickReply> get welcomeReplies => _quickReplySet.welcome;
  List<QuickReply> get inputReplies => _quickReplySet.input;
  bool get isLoading => _isLoading;
  bool get isTyping => _isTyping;
  String? get errorMessage => _errorMessage;

  String get text => textController.text;
  bool get canSend =>
      text.trim().isNotEmpty && !_isTyping && !_isLoading;

  /// Contoh: "Hari ini, 09.40 WIB".
  String get dateLabel {
    String two(int value) => value.toString().padLeft(2, '0');
    return 'Hari ini, ${two(_openedAt.hour)}.${two(_openedAt.minute)} WIB';
  }

  Future<void> load() async {
    if (!_isLoading && _messages.isNotEmpty) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final welcome = await _getWelcomeMessage(userName: userName);
      _messages
        ..clear()
        ..add(welcome);
      _quickReplySet = await _getQuickReplies();
    } catch (_) {
      _errorMessage = 'Gagal memuat asisten. Coba lagi ya.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> send({String? preset}) async {
    final message = (preset ?? textController.text).trim();
    if (message.isEmpty || _isTyping || _isLoading) return;

    textController.clear();
    _messages.add(
      ChatMessage(
        id: 'user-${_sequence++}',
        sender: ChatSender.user,
        type: ChatMessageType.text,
        text: message,
        sentAt: DateTime.now(),
      ),
    );
    _isTyping = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final reply = await _sendMessage(message);
      _messages.addAll(reply.messages);
      _quickReplySet = QuickReplySet(
        welcome: _quickReplySet.welcome,
        input: reply.quickReplies,
      );
    } catch (_) {
      _errorMessage = 'Koneksi ke asisten terputus. Coba kirim lagi.';
      _messages.add(
        ChatMessage(
          id: 'error-${_sequence++}',
          sender: ChatSender.bot,
          type: ChatMessageType.text,
          text: 'Maaf, terjadi kendala saat memproses pesanmu. Coba lagi ya.',
          sentAt: DateTime.now(),
        ),
      );
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  void sendQuickReply(QuickReply reply) => send(preset: reply.prompt);

  void _onTextChanged() => notifyListeners();

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();
    super.dispose();
  }
}
