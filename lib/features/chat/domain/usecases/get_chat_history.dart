import 'package:dartz/dartz.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/chat_message/chat_message.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/repositories/chat_repository.dart';

class GetChatHistory {
  final ChatRepository repository;

  GetChatHistory(this.repository);

  Future<Either<List<ChatMessage>, List<ChatMessage>>> call() async {
    return await repository.getChatHistory();
  }
}
