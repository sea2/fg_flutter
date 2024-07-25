import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

class MessageVideoTileFactoryDelegate
    implements ITileFactoryDelegate<MessageVideoTileModel> {
  MessageVideoTileFactoryDelegate({
    required ChatMessageFactory chatMessageFactory,
    required MessageComponentResolver messageComponentResolver,
    required ShortInfoFactory shortInfoFactory,
    required ImageWidgetFactory imageWidgetFactory,
    required ReplyInfoFactory replyInfoFactory,
  })  : _chatMessageFactory = chatMessageFactory,
        _shortInfoFactory = shortInfoFactory,
        _imageWidgetFactory = imageWidgetFactory,
        _messageComponentResolver = messageComponentResolver,
        _replyInfoFactory = replyInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ImageWidgetFactory _imageWidgetFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final ShortInfoFactory _shortInfoFactory;
  final MessageComponentResolver _messageComponentResolver;

  @override
  Widget create(BuildContext context, MessageVideoTileModel model) {
    final ChatContextData chatContextData = ChatContext.of(context);
    return _chatMessageFactory.createConversationMessage(
      isOutgoing: model.isOutgoing,
      context: context,
      senderTitle: _messageComponentResolver.resolveSenderName(context, model),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        MediaWrapper(
          type: MediaType.video,
          child: _imageWidgetFactory.create(
            context,
            minithumbnail: model.minithumbnail,
            imageId: model.thumbnailImageId,
          ),
          // todo maybe crash
          width: model.minithumbnail!.width,
          height: model.minithumbnail!.height,
        ),
        if (model.caption != null)
          MessageCaption(
            padding: EdgeInsets.only(
              left: chatContextData.horizontalPadding,
              right: chatContextData.horizontalPadding,
              top: chatContextData.verticalPadding,
            ),
            text: model.caption!,
            shortInfo: _shortInfoFactory.create(
              context: context,
              additionalInfo: model.additionalInfo,
              isOutgoing: model.isOutgoing,
              padding: EdgeInsets.only(
                bottom: chatContextData.verticalPadding,
              ),
            ),
          ),
      ],
    );
  }
}
