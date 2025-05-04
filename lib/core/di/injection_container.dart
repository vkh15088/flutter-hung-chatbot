import 'package:flutter_hung_chatbot/core/di/core_injection_container.dart';
import 'package:flutter_hung_chatbot/features/chat/di/chat_injection_container.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

/// Initializes all dependencies for the application
Future<void> init() async {
  // Register core dependencies (shared across features)
  registerCoreDependencies(sl);

  // Register feature-specific dependencies
  registerChatDependencies(sl);
}
