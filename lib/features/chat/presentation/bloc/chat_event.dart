import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatHistory extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;
  final bool isStreamMode;

  const SendMessageEvent({required this.message, required this.isStreamMode});

  @override
  List<Object> get props => [message, isStreamMode];
}

class ToggleStreamModeEvent extends ChatEvent {
  final bool isStreamMode;

  const ToggleStreamModeEvent({required this.isStreamMode});

  @override
  List<Object> get props => [isStreamMode];
}

class TouchingScreenEvent extends ChatEvent {
  final bool isTouching;

  const TouchingScreenEvent({required this.isTouching});

  @override
  List<Object> get props => [isTouching];
}

class MessageStreamUpdateEvent extends ChatEvent {
  final String textChunk;

  const MessageStreamUpdateEvent({required this.textChunk});

  @override
  List<Object> get props => [textChunk];
}
