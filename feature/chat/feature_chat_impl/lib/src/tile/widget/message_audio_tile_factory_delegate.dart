import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_format/rich_text_format.dart' as rt;
import 'package:tile/tile.dart';

class MessageAudioTileFactoryDelegate
    implements ITileFactoryDelegate<MessageAudioTileModel> {
  MessageAudioTileFactoryDelegate({
    required ShortInfoFactory shortInfoFactory,
    required ReplyInfoFactory replyInfoFactory,
    required MessageComponentResolver messageComponentResolver,
    required ChatMessageFactory chatMessageFactory,
  })  : _shortInfoFactory = shortInfoFactory,
        _replyInfoFactory = replyInfoFactory,
        _messageComponentResolver = messageComponentResolver,
        _chatMessageFactory = chatMessageFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ShortInfoFactory _shortInfoFactory;
  final ReplyInfoFactory _replyInfoFactory;
  final MessageComponentResolver _messageComponentResolver;

  @override
  Widget create(BuildContext context, MessageAudioTileModel model) {
    final ChatContextData chatContext = ChatContext.of(context);
    final ThemeData theme = Theme.of(context);
    return _chatMessageFactory.createConversationMessage(
      isOutgoing: model.isOutgoing,
      context: context,
      senderTitle: _messageComponentResolver.resolveSenderName(context, model),
      reply: _replyInfoFactory.createFromMessageModel(context, model),
      blocks: <Widget>[
        Padding(
          // todo symetric?
          padding: EdgeInsets.only(
            top: chatContext.verticalPadding,
            bottom: chatContext.verticalPadding,
            right: chatContext.horizontalPadding,
            left: chatContext.horizontalPadding,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // todo implement play button
              const CircleAvatar(
                radius: 25,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      model.performer,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MessageText(
                      // todo move to model
                      text: rt.RichText(
                        entities: <rt.Entity>[
                          rt.Entity(
                            text: '00:00 / ${model.totalDuration}',
                            types: <rt.Type>[const rt.Type.planeText()],
                          ),
                        ],
                      ),
                      shortInfo: _shortInfoFactory.create(
                        context: context,
                        additionalInfo: model.additionalInfo,
                        isOutgoing: model.isOutgoing,
                        padding: EdgeInsets.only(
                          bottom: chatContext.verticalPadding,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
