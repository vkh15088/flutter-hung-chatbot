import 'package:flutter/material.dart';
import 'package:flutter_hung_chatbot/core/constants/app_theme.dart';

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
      padding: const EdgeInsets.all(AppDimensions.paddingS),
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      child: TextField(
        controller: _controller,
        maxLines: 1,
        style: AppTextStyles.inputText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          prefixIcon: IconButton(
            onPressed: () => widget.onChangeStreamMode(),
            icon: Icon(Icons.stream, color: widget.isStreamMode ? AppColors.iconActive : AppColors.iconInactive),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              widget.onSendMessage(_controller.text);
              if (widget.isClearText) _controller.clear();
            },
            icon: const Icon(Icons.send, color: AppColors.iconActive),
          ),
        ),
        onSubmitted: (value) {
          widget.onSendMessage(value);
          if (widget.isClearText) _controller.clear();
        },
      ),
    );
  }
}
