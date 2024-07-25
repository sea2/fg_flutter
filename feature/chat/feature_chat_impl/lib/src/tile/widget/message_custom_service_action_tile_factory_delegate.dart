import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message_factory.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageCustomServiceActionTileFactoryDelegate
    implements ITileFactoryDelegate<MessageCustomServiceActionTileModel> {
  MessageCustomServiceActionTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
  }) : _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;

  @override
  Widget create(
    BuildContext context,
    MessageCustomServiceActionTileModel model,
  ) {
    return _chatMessageFactory.createChatNotificationFromText(
      context: context,
      text: model.title,
    );
  }
}
