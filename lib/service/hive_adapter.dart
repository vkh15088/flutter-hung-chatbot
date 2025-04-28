import 'package:hive/hive.dart';

part 'hive_adapter.g.dart';

@HiveType(typeId: 0)
class ChatContent extends HiveObject {
  @HiveField(1)
  Sender sender;
  @HiveField(2)
  String message;

  ChatContent({
    required this.sender,
    required this.message,
  });

  ChatContent.user(this.message) : sender = Sender.user;
  ChatContent.gemini(this.message) : sender = Sender.gemini;
}

@HiveType(typeId: 1)
enum Sender {
  @HiveField(0)
  user,
  @HiveField(1)
  gemini,
}
