import 'package:flutter/material.dart';
import 'package:flutter_agrowisatajeruk/core/di/dependencies.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_colors.dart';
import 'package:flutter_agrowisatajeruk/core/theme/app_sizes.dart';

import '../../domain/entities/chat_message.dart';
import '../viewmodels/chatbot_viewmodel.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_quick_bar.dart';
import '../widgets/chatbot_header.dart';
import '../widgets/quick_reply_chips.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/tips_card.dart';
import '../widgets/typing_indicator.dart';

/// Halaman full screen "Tanya Jeruk" (rute /chatbot).
class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  late final ChatbotViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel = AppDependencies.instance.createChatbotViewModel()
      ..addListener(_scrollToLatest)
      ..load();
  }

  @override
  void dispose() {
    _viewModel
      ..removeListener(_scrollToLatest)
      ..dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  void _showMapSoon() {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      const SnackBar(
        content: Text('Peta kebun segera hadir'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: const ChatbotHeader(),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading && _viewModel.messages.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.errorMessage != null &&
              _viewModel.messages.isEmpty) {
            return _buildError();
          }

          return Column(
            children: [
              Expanded(child: _buildConversation()),
              if (_viewModel.inputReplies.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSizes.chatQuickBarVertical,
                    bottom: AppSizes.chatQuickBarVertical,
                  ),
                  child: ChatQuickBar(
                    replies: _viewModel.inputReplies,
                    onTap: _viewModel.sendQuickReply,
                  ),
                ),
              ChatInputBar(
                controller: _viewModel.textController,
                canSend: _viewModel.canSend,
                onSend: _viewModel.send,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConversation() {
    final messages = _viewModel.messages;
    final children = <Widget>[
      Center(
        child: Container(
          height: AppSizes.chatDateChipHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.chatDateChipHorizontal,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kChipGrey,
            borderRadius: BorderRadius.circular(AppSizes.radiusPill),
          ),
          child: Text(_viewModel.dateLabel, style: AppTextStyles.chatDateChip),
        ),
      ),
      const SizedBox(height: AppSizes.chatWelcomeGap),
    ];

    if (messages.isNotEmpty) {
      children
        ..add(_buildMessage(messages.first))
        ..add(QuickReplyChips(
          replies: _viewModel.welcomeReplies,
          onTap: _viewModel.sendQuickReply,
        ));
    }

    for (final message in messages.skip(1)) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: AppSizes.chatMessageGap),
          child: _buildMessage(message),
        ),
      );
    }

    if (_viewModel.isTyping) {
      children.add(
        const Padding(
          padding: EdgeInsets.only(top: AppSizes.chatMessageGap),
          child: TypingIndicator(),
        ),
      );
    }

    return ListView(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(
        AppSizes.chatPageHorizontal,
        AppSizes.chatListTop,
        AppSizes.chatPageHorizontal,
        AppSizes.chatScrollBottomPadding,
      ),
      children: children,
    );
  }

  Widget _buildMessage(ChatMessage message) {
    return switch (message.type) {
      ChatMessageType.recommendation => RecommendationCard(
        recommendation: message.recommendation!,
        onMapTap: _showMapSoon,
        onOrderTap: () => Navigator.pushNamed(context, '/pesan-tiket'),
      ),
      ChatMessageType.tips => TipsCard(text: message.text),
      ChatMessageType.text => ChatBubble(message: message),
    };
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.chatErrorPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: AppSizes.chatErrorIcon,
              color: kTextMuted,
            ),
            const SizedBox(height: AppSizes.chatErrorGap),
            Text(
              _viewModel.errorMessage!,
              textAlign: TextAlign.center,
              style: AppTextStyles.chatBubble,
            ),
            const SizedBox(height: AppSizes.chatErrorActionGap),
            OutlinedButton(
              onPressed: _viewModel.load,
              style: OutlinedButton.styleFrom(
                foregroundColor: kPrimaryGreen,
                side: const BorderSide(color: kPrimaryGreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
