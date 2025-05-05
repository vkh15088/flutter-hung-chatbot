import 'package:flutter_hung_chatbot/core/error/exceptions.dart';
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:hive/hive.dart';

abstract class ChatLocalDataSource {
  /// Gets the cached list of chat messages
  ///
  /// Throws [CacheException] if no cached data is present
  Future<List<ChatMessageModel>> getChatHistory();

  /// Caches the chat messages
  Future<void> cacheChatMessages(List<ChatMessageModel> messages);

  /// Adds a new message to the cache
  Future<void> addChatMessage(ChatMessageModel message);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box box;

  ChatLocalDataSourceImpl({required this.box});

  @override
  Future<List<ChatMessageModel>> getChatHistory() async {
    try {
      final chatList = box.get('chatList', defaultValue: []);
      if (chatList is List) {
        return chatList.cast<ChatMessageModel>();
      }
      return [];
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheChatMessages(List<ChatMessageModel> messages) async {
    try {
      await box.put('chatList', messages);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addChatMessage(ChatMessageModel message) async {
    try {
      final chatList = await getChatHistory();
      chatList.add(message);
      await cacheChatMessages(chatList);
    } catch (e) {
      throw CacheException();
    }
  }
}
