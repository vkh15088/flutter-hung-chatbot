import 'package:flutter_hung_chatbot/core/constants/hive_type_ids.dart';
import 'package:flutter_hung_chatbot/features/chat/domain/entities/chat_message/chat_message.dart' as domain;
import 'package:hive/hive.dart';

part 'chat_message_model.g.dart';

@HiveType(typeId: HiveTypeIds.chatContent)
class ChatMessageModel extends HiveObject {
  @HiveField(0)
  final SenderType sender;
  @HiveField(1)
  final String message;

  ChatMessageModel({required this.sender, required this.message});

  ChatMessageModel.user(this.message) : sender = SenderType.user;
  ChatMessageModel.gemini(this.message) : sender = SenderType.gemini;

  ChatMessageModel copyWith({SenderType? sender, String? message}) {
    return ChatMessageModel(sender: sender ?? this.sender, message: message ?? this.message);
  }

  domain.ChatMessage toEntity() {
    return domain.ChatMessage(sender: _mapSenderType(sender), message: message);
  }

  static ChatMessageModel fromEntity(domain.ChatMessage chatMessage) {
    return ChatMessageModel(sender: _mapToHiveSenderType(chatMessage.sender), message: chatMessage.message);
  }

  static domain.SenderType _mapSenderType(SenderType senderType) {
    switch (senderType) {
      case SenderType.user:
        return domain.SenderType.user;
      case SenderType.gemini:
        return domain.SenderType.gemini;
    }
  }

  static SenderType _mapToHiveSenderType(domain.SenderType senderType) {
    switch (senderType) {
      case domain.SenderType.user:
        return SenderType.user;
      case domain.SenderType.gemini:
        return SenderType.gemini;
    }
  }
}

@HiveType(typeId: HiveTypeIds.sender)
enum SenderType {
  @HiveField(0)
  user,
  @HiveField(1)
  gemini,
}
