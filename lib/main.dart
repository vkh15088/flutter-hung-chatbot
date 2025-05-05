import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hung_chatbot/core/di/injection_container.dart' as di;
import 'package:flutter_hung_chatbot/features/chat/data/models/chat_message_model.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_hung_chatbot/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter_hung_chatbot/flavors.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere((element) => element.name == appFlavor);
  await dotenv.load(fileName: F.envFile);
  await Hive.initFlutter();

  // Register Hive adapters
  Hive.registerAdapter(ChatMessageModelAdapter());
  Hive.registerAdapter(SenderTypeAdapter());

  await Hive.openBox('myBox');

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ChatBloc>(),
      child: const MaterialApp(debugShowCheckedModeBanner: false, home: ChatPage()),
    );
  }
}
