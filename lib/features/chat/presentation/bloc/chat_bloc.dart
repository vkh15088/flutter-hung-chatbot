import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/usecases/get_chat_history.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/usecases/send_message.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_event.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessage sendMessage;
  final GetChatHistory getChatHistory;

  StreamSubscription? _messageStreamSubscription;

  ChatBloc({required this.sendMessage, required this.getChatHistory}) : super(ChatState.initial()) {
    on<LoadChatHistory>(_onLoadChatHistory);
    on<SendMessageEvent>(_onSendMessage);
    on<ToggleStreamModeEvent>(_onToggleStreamMode);
    on<TouchingScreenEvent>(_onTouchingScreen);
    on<MessageStreamUpdateEvent>(_onMessageStreamUpdate);
    on<ChangeModelEvent>(_onChangeModel);
  }

  Future<void> _onLoadChatHistory(LoadChatHistory event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading));

    final result = await getChatHistory();

    result.fold(
      (failure) => emit(state.copyWith(status: ChatStatus.error, error: 'Load Chat History Failed')),
      (messages) => emit(
        state.copyWith(
          status: ChatStatus.success,
          messages: messages.map((e) => ChatMessageModel.fromEntity(e)).toList(),
          currentEvent: ChatEventStatus.idle,
        ),
      ),
    );
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    if (event.message.isEmpty ||
        state.currentEvent == ChatEventStatus.waitingResponse ||
        state.currentEvent == ChatEventStatus.renderingResponse) {
      return;
    }

    // Add user message to the state
    final userMessage = ChatMessageModel(sender: SenderType.user, message: event.message);
    final geminiMessage = ChatMessageModel(sender: SenderType.gemini, message: '');

    final updatedMessages =
        List<ChatMessageModel>.from(state.messages)
          ..add(userMessage)
          ..add(geminiMessage);

    emit(state.copyWith(messages: updatedMessages, currentEvent: ChatEventStatus.waitingResponse));

    if (event.isStreamMode) {
      // Listen to the stream and update the state
      _messageStreamSubscription?.cancel();
      _messageStreamSubscription =
          await sendMessage
              .getStream(event.message, state.model)
              .listen(
                (result) {
                  emit(state.copyWith(currentEvent: ChatEventStatus.renderingResponse));
                  result.fold(
                    (failure) => add(MessageStreamUpdateEvent(textChunk: failure.error.message)),
                    (textChunk) => add(MessageStreamUpdateEvent(textChunk: textChunk)),
                  );
                },
                onError: (error) {
                  emit(
                    state.copyWith(
                      status: ChatStatus.error,
                      error: error.toString(),
                      currentEvent: ChatEventStatus.finishedResponse,
                    ),
                  );
                },
              )
              .asFuture();
      emit(state.copyWith(status: ChatStatus.success, currentEvent: ChatEventStatus.finishedResponse));
    } else {
      // Non-stream mode
      final result = await sendMessage(event.message, state.model);

      await result.fold(
        (failure) {
          final errorMessage = failure.error.message;

          final messagesWithError = List<ChatMessageModel>.from(updatedMessages)
            ..last = updatedMessages.last.copyWith(message: errorMessage);

          emit(
            state.copyWith(
              messages: messagesWithError,
              status: ChatStatus.error,
              error: errorMessage,
              currentEvent: ChatEventStatus.finishedResponse,
            ),
          );
        },
        (aiMessage) async {
          emit(state.copyWith(currentEvent: ChatEventStatus.renderingResponse));
          final message = aiMessage.message;

          for (int i = 0; i < message.length; i++) {
            await Future.delayed(const Duration(milliseconds: 10), () {
              final subText = message.substring(0, i);
              final updatedMessages = List<ChatMessageModel>.from(state.messages)
                ..last = state.messages.last.copyWith(message: subText);
              emit(state.copyWith(messages: updatedMessages));
            });
          }

          emit(state.copyWith(status: ChatStatus.success, currentEvent: ChatEventStatus.finishedResponse));
        },
      );
    }
  }

  void _onToggleStreamMode(ToggleStreamModeEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(isStreamMode: event.isStreamMode));
  }

  void _onTouchingScreen(TouchingScreenEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(isTouchingScreen: event.isTouching));
  }
  
  void _onChangeModel(ChangeModelEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(model: event.model));
  }

  void _onMessageStreamUpdate(MessageStreamUpdateEvent event, Emitter<ChatState> emit) {
    if (state.messages.isEmpty) return;

    final updatedMessages = List<ChatMessageModel>.from(state.messages);
    final lastMessage = updatedMessages.last;

    if (lastMessage.sender == SenderType.gemini) {
      final updatedLastMessage = ChatMessageModel(
        sender: lastMessage.sender,
        message: lastMessage.message + event.textChunk,
      );

      updatedMessages[updatedMessages.length - 1] = updatedLastMessage;

      emit(state.copyWith(messages: updatedMessages));
    }
  }

  @override
  Future<void> close() {
    _messageStreamSubscription?.cancel();
    return super.close();
  }
}
