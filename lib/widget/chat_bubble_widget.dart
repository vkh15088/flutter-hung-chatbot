import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatBubble extends StatelessWidget {
  final bool isMine;
  final String? photoUrl;
  final String message;

  const ChatBubble({
    super.key,
    required this.isMine,
    required this.photoUrl,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    //Avatar
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: photoUrl == null
              ? const _DefaultPersonWidget()
              : CachedNetworkImage(
                  height: 30,
                  width: 30,
                  imageUrl: photoUrl ?? '',
                  errorWidget: (context, url, error) => const _DefaultPersonWidget(),
                  placeholder: (context, url) => const _DefaultPersonWidget(),
                ),
        ),
      ),
    );

    //Message bubble
    widgets.add(
      Container(
        padding: const EdgeInsets.all(8),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isMine ? Colors.black26 : Colors.black87,
        ),
        child: MarkdownBody(
          data: message,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            a: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: isMine ? widgets.reversed.toList() : widgets,
      ),
    );
  }
}

class _DefaultPersonWidget extends StatelessWidget {
  const _DefaultPersonWidget();

  @override
  Widget build(BuildContext context) => const Icon(Icons.person, color: Colors.black, size: 12);
}
