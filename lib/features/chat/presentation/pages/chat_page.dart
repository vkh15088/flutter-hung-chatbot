import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hung_chatbot/core/constants/app_theme.dart';
import 'package:flutter_hung_chatbot/core/di/injection_container.dart' as di;
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/ai_model.dart';
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ChatBloc>()..add(LoadChatHistory()),
      child: Scaffold(appBar: _buildAppbar(), body: _buildBody()),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: BlocSelector<ChatBloc, ChatState, AIModel>(
        selector: (state) => state.model,
        builder:
            (context, state) => TextButton(
              onPressed: () {
                final currentBloc = context.read<ChatBloc>();
                showModalBottomSheet<void>(
                  context: context,
                  builder:
                      (BuildContext context) => _ModelListSheet(
                        model: state,
                        onModelSelected: (model) {
                          currentBloc.add(ChangeModelEvent(model: model));
                          Navigator.pop(context);
                        },
                      ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.displayName, style: AppTextStyles.heading3),
                  const Icon(Icons.arrow_drop_down, size: 30),
                ],
              ),
            ),
      ),
    );
  }

  BlocConsumer<ChatBloc, ChatState> _buildBody() {
    return BlocConsumer<ChatBloc, ChatState>(
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
    );
  }

  Widget _buildChatList(ChatState state) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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

class _ModelListSheet extends StatelessWidget {
  final AIModel model;
  final Function(AIModel) onModelSelected;

  const _ModelListSheet({required this.model, required this.onModelSelected});

  @override
  Widget build(BuildContext context) {
    final allModels = AIModel.allModels;
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      width: double.infinity,
      child: Column(mainAxisSize: MainAxisSize.min, children: allModels.map(_buildModelItem).toList()),
    );
  }

  Widget _buildModelItem(AIModel model) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: model == this.model ? AppColors.primary : AppColors.backgroundDark,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
        ),
        onPressed: () => onModelSelected(model),
        child: Text(model.displayName, style: AppTextStyles.buttonText),
      ),
    );
  }
}
