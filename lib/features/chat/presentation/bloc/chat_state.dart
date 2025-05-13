import 'package:equatable/equatable.dart';
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/ai_model.dart';

enum ChatStatus { initial, loading, success, error }

enum ChatEventStatus { start, idle, waitingResponse, renderingResponse, finishedResponse }

class ChatState extends Equatable {
  final List<ChatMessageModel> messages;
  final ChatStatus status;
  final bool isStreamMode;
  final bool isTouchingScreen;
  final String error;
  final AIModel model;
  final ChatEventStatus currentEvent;

  const ChatState({
    required this.messages,
    required this.status,
    required this.isStreamMode,
    required this.isTouchingScreen,
    required this.error,
    required this.model,
    required this.currentEvent,
  });

  factory ChatState.initial() {
    return ChatState(
      messages: [],
      status: ChatStatus.initial,
      isStreamMode: false,
      isTouchingScreen: false,
      error: '',
      model: AIModel.defaultModel,
      currentEvent: ChatEventStatus.idle,
    );
  }

  ChatState copyWith({
    List<ChatMessageModel>? messages,
    ChatStatus? status,
    bool? isStreamMode,
    bool? isTouchingScreen,
    String? error,
    AIModel? model,
    ChatEventStatus? currentEvent,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      isStreamMode: isStreamMode ?? this.isStreamMode,
      isTouchingScreen: isTouchingScreen ?? this.isTouchingScreen,
      error: error ?? this.error,
      model: model ?? this.model,
      currentEvent: currentEvent ?? this.currentEvent,
    );
  }

  @override
  List<Object> get props => [messages, status, isStreamMode, isTouchingScreen, error, model, currentEvent];
}
