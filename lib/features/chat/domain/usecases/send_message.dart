import 'package:dartz/dartz.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/gemini/gemini_error.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<Either<GeminiError, ChatMessage>> call(String message) async {
    return await repository.sendMessage(message);
  }

  Stream<Either<GeminiError, String>> getStream(String message) {
    return repository.getMessageStream(message);
  }
}
