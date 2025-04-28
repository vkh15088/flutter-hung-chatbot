import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hung_chatbot/flavors.dart';
import 'package:flutter_hung_chatbot/provider/chat_provider.dart';
import 'package:flutter_hung_chatbot/service/hive_adapter.dart';
import 'package:flutter_hung_chatbot/widget/chat_bubble_widget.dart';
import 'package:flutter_hung_chatbot/widget/message_box_widget.dart';
import 'package:flutter_hung_chatbot/worker/genai_worker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  F.appFlavor = Flavor.values.firstWhere((element) => element.name == appFlavor);
  await dotenv.load(fileName: F.envFile);
  await Hive.initFlutter();
  Hive.registerAdapter(ChatContentAdapter());
  Hive.registerAdapter(SenderAdapter());
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ChatProvider())],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(body: _Body())),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final avatar =
      'https://static.vecteezy.com/system/resources/previews/002/002/403/non_2x/man-with-beard-avatar-character-isolated-icon-free-vector.jpg';
  final _worker = GenaiWorker();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder:
          (context, value, child) => Listener(
            onPointerDown: (event) => value.enableTouchingScreen(),
            onPointerUp: (event) => value.disableTouchingScreen(),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<ChatEvent>(
                    stream: _worker.eventStream,
                    builder:
                        (context, eventSnapshot) => StreamBuilder<List<ChatContent>>(
                          stream: _worker.chatListStream,
                          builder: (context, chatListSnapshot) {
                            final chatEvent = eventSnapshot.data;
                            final chatList = chatListSnapshot.data ?? [];

                            return GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Scrollbar(
                                  controller: _scrollController,
                                  child: ListView(
                                    controller: _scrollController,
                                    reverse: true,
                                    shrinkWrap: true,
                                    children:
                                        chatList.reversed.map((e) {
                                          if (e.sender == Sender.gemini && e == chatList.last) {
                                            if (!value.isTouchingScreen &&
                                                _scrollController.hasClients &&
                                                _scrollController.offset <= 100) {
                                              _scrollController.jumpTo(0);
                                            }
                                          }

                                          if (chatEvent == ChatEvent.waitingResponse &&
                                              e.sender == Sender.gemini &&
                                              e == chatList.last) {
                                            return ChatBubble(
                                              isMine: e.sender == Sender.user,
                                              photoUrl: e.sender == Sender.user ? null : avatar,
                                              message: '...',
                                            );
                                          }

                                          return ChatBubble(
                                            isMine: e.sender == Sender.user,
                                            photoUrl: e.sender == Sender.user ? null : avatar,
                                            message: e.message,
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ),
                MessageBox(
                  isStreamMode: value.isStreamMode,
                  onChangeStreamMode: () => value.toggleStreamMode(),
                  isClearText: !isRendering(),
                  onSendMessage: (String text) {
                    if (text.isEmpty || isRendering()) {
                      return;
                    }
                    _worker.sendToGemini(text, value.isStreamMode);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    });
                  },
                ),
              ],
            ),
          ),
    );
  }

  bool isRendering() =>
      _worker.chatEvent == ChatEvent.waitingResponse || _worker.chatEvent == ChatEvent.renderingResponse;
}
