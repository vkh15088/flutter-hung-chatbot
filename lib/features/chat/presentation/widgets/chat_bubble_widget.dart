import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hung_chatbot/core/constants/app_theme.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChatBubble extends StatelessWidget {
  final bool isMine;
  final String? photoUrl;
  final String message;

  const ChatBubble({super.key, required this.isMine, required this.photoUrl, required this.message});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    //Avatar
    widgets.add(
      Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          child: photoUrl == null
              ? const _DefaultPersonWidget()
              : CachedNetworkImage(
                  height: AppDimensions.avatarM,
                  width: AppDimensions.avatarM,
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
        padding: const EdgeInsets.all(AppDimensions.paddingS),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * AppDimensions.chatBubbleMaxWidthFactor),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          color: isMine ? AppColors.myMessageBubble : AppColors.otherMessageBubble,
        ),
        child: MarkdownBody(
          data: message,
          styleSheet: MarkdownStyleSheet(
            p: AppTextStyles.chatMessage,
            a: AppTextStyles.chatMessageLink,
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
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
  Widget build(BuildContext context) =>
      const Icon(Icons.person, color: AppColors.iconInactive, size: AppDimensions.iconS);
}
