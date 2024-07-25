import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageChatDeletePhotoTileFactoryDelegate
    implements ITileFactoryDelegate<MessageChatDeletePhotoTileModel> {
  MessageChatDeletePhotoTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
  }) : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(BuildContext context, MessageChatDeletePhotoTileModel model) {
    return _chatMessageFactory.createChatNotificationFromText(
      context: context,
      text: model.title,
    );
  }
}
