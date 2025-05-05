import 'package:equatable/equatable.dart';

enum SenderType { user, gemini }

class ChatMessage extends Equatable {
  final SenderType sender;
  final String message;

  const ChatMessage({required this.sender, required this.message});

  @override
  List<Object> get props => [sender, message];
}
