import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final ValueChanged<String> onSendMessage;
  final bool isClearText;
  final bool isStreamMode;
  final VoidCallback onChangeStreamMode;

  const MessageBox({
    super.key,
    required this.onSendMessage,
    required this.isClearText,
    required this.isStreamMode,
    required this.onChangeStreamMode,
  });

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: _controller,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.black38, width: 1),
          ),
          prefixIcon: IconButton(
            onPressed: () => widget.onChangeStreamMode.call(),
            icon: Icon(Icons.stream, color: widget.isStreamMode ? Colors.blue : Colors.black),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              widget.onSendMessage.call(_controller.text);
              if (widget.isClearText) _controller.clear();
            },
            icon: const Icon(Icons.send),
          ),
        ),
        onSubmitted: (value) {
          widget.onSendMessage.call(value);
          if (widget.isClearText) _controller.clear();
        },
      ),
    );
  }
}
