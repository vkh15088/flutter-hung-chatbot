import 'dart:async';

import 'package:flutter_hung_chatbot/flavors.dart';
import 'package:flutter_hung_chatbot/service/hive_adapter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hive/hive.dart';

enum ChatEvent { start, idle, waitingResponse, renderingResponse, finishedResponse }

class GenaiWorker {
  late final GenerativeModel _model;

  final List<ChatContent> _content = [];
  List<ChatContent> get content => _content;

  final StreamController<List<ChatContent>> _chatListStreamController = StreamController.broadcast();
  Stream<List<ChatContent>> get chatListStream => _chatListStreamController.stream;

  ChatEvent _chatEvent = ChatEvent.start;
  ChatEvent get chatEvent => _chatEvent;

  final StreamController<ChatEvent> _eventStreamController = StreamController.broadcast();
  Stream<ChatEvent> get eventStream => _eventStreamController.stream;

  final _box = Hive.box('myBox');

  GenaiWorker() {
    final apiKey = F.getApiKey;
    print('ahihi apiKey $apiKey');
    _model = GenerativeModel(model: 'gemini-2.0-flash-lite', apiKey: apiKey);
    _content.addAll(_box.get('chatList', defaultValue: []).cast<ChatContent>());
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _setEvent(ChatEvent.start);
      _chatListStreamController.sink.add(_content);
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        _setEvent(ChatEvent.idle);
      });
    });
  }

  void sendToGemini(String message, bool isStreamMode) async {
    print('ahihi message $message');
    _setEvent(ChatEvent.waitingResponse);
    _content.add(ChatContent.user(message));
    _content.add(ChatContent.gemini(''));
    _chatListStreamController.sink.add(_content);
    await _box.put('chatList', List.of(_content));

    try {
      if (isStreamMode) {
        final response = _model.generateContentStream([Content.text(message)]);
        _setEvent(ChatEvent.renderingResponse);

        // Process the stream
        await for (final chunk in response) {
          if (chunk.text == null) {
            _handleNullData();
          } else {
            _content.last.message += chunk.text!;
            _chatListStreamController.sink.add(_content);
            await _box.put('chatList', List.of(_content));
          }
        }
        _setEvent(ChatEvent.finishedResponse);
        return;
      }

      //If not stream mode
      final response = await _model.generateContent([Content.text(message)]);
      final text = response.text;

      _setEvent(ChatEvent.renderingResponse);
      if (text == null) {
        _handleNullData();
      } else {
        for (int i = 0; i < text.length; i++) {
          await Future.delayed(const Duration(milliseconds: 10), () {
            final subText = text.substring(0, i);
            _content.last.message = subText;
            _chatListStreamController.sink.add(_content);
          });
        }
        await _box.put('chatList', List.of(_content));
        _setEvent(ChatEvent.finishedResponse);
      }
    } catch (e) {
      _handleNullData();
    }
  }

  _setEvent(ChatEvent event) {
    _chatEvent = event;
    _eventStreamController.sink.add(_chatEvent);
  }

  _handleNullData() async {
    _content.last.message = 'Unable to generate response';
    _chatListStreamController.sink.add(_content);
    _setEvent(ChatEvent.finishedResponse);
    await _box.put('chatList', List.of(_content));
  }
}
