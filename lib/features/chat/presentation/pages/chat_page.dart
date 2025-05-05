import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_event.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/widgets/chat_bubble_widget.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/widgets/message_box_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _scrollController = ScrollController();
  final avatar =
      'https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg';

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChatHistory());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state.currentEvent == ChatEventStatus.renderingResponse &&
              state.messages.isNotEmpty &&
              state.messages.last.sender == SenderType.gemini &&
              !state.isTouchingScreen &&
              _scrollController.hasClients &&
              _scrollController.offset <= 100) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          return Listener(
            onPointerDown: (event) => context.read<ChatBloc>().add(const TouchingScreenEvent(isTouching: true)),
            onPointerUp: (event) => context.read<ChatBloc>().add(const TouchingScreenEvent(isTouching: false)),
            child: Column(
              children: [
                Expanded(child: _buildChatList(state)),
                MessageBox(
                  isStreamMode: state.isStreamMode,
                  onChangeStreamMode:
                      () => context.read<ChatBloc>().add(ToggleStreamModeEvent(isStreamMode: !state.isStreamMode)),
                  isClearText: _isClearText(state),
                  onSendMessage: (String text) {
                    if (text.isEmpty || !_isClearText(state)) {
                      return;
                    }

                    context.read<ChatBloc>().add(SendMessageEvent(message: text, isStreamMode: state.isStreamMode));

                    _scrollToBottom();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatList(ChatState state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            shrinkWrap: true,
            itemCount: state.messages.length,
            itemBuilder: (context, index) {
              final reversedIndex = state.messages.length - 1 - index;
              final message = state.messages[reversedIndex];

              // Show loading indicator for the last AI message when waiting for response
              if (state.currentEvent == ChatEventStatus.waitingResponse &&
                  message.sender == SenderType.gemini &&
                  reversedIndex == state.messages.length - 1) {
                return ChatBubble(isMine: false, photoUrl: avatar, message: '...');
              }

              return ChatBubble(
                isMine: message.sender == SenderType.user,
                photoUrl: message.sender == SenderType.user ? null : avatar,
                message: message.message,
              );
            },
          ),
        ),
      ),
    );
  }

  bool _isClearText(ChatState state) {
    return state.currentEvent != ChatEventStatus.waitingResponse &&
        state.currentEvent != ChatEventStatus.renderingResponse;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }
}
