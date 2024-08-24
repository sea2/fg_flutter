import 'dart:math' as math;

import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'chat_screen.dart';
import 'message_factory.dart';
import 'messages_bundle.dart';
import 'package:td_client/td_client.dart' as tdClient;
import 'package:td_api/td_api.dart' as td;

class MessagesList extends StatefulWidget {
   MessagesList({
    super.key,
    required this.messagesBundle,
    this.chatId=0,
  });
  int chatId;
  final IMessagesBundle messagesBundle;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final ScrollController _scrollController = ScrollController();
  bool _scrolledToOldest = false;

  ChatMessagesViewModel? _viewModel;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (!_scrolledToOldest && _scrollController.position.extentAfter < 300) {
        _scrolledToOldest = true;
        _viewModel?.onLoadOldestMessages();
      } else if (_scrolledToOldest &&
          _scrollController.position.extentAfter >= 300) {
        _scrolledToOldest = false;
      }
    });
    List<int> messageIds=[];
    this.widget.messagesBundle.getModels.forEach((element) {
      if (element is BaseConversationMessageTileModel) {
        messageIds.add(element.id);
        print("消息id &${element.id}");
      }else  if (element is BaseMessageTileModel) {
        messageIds.add(element.id);
        print("消息id ${element.id}");
      }
    });
    tdClient.ClientSingleton.getClient().send<td.Ok>(td.ViewMessages(chatId:widget.chatId,messageThreadId:0,forceRead: true,messageIds: messageIds),).then((value) {
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = ChatScreenScope.getChatMessagesViewModel(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final MessageFactory messageFactory =
        ChatScreenScope.getMessageFactory(context);
    return Scrollbar(
      child: ListView.custom(
        controller: _scrollController,
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final int itemIndex = index ~/ 2;
            final Widget widget;
            if (index.isEven) {
              final ITileModel tileModel =
                  this.widget.messagesBundle[itemIndex];
              widget = Padding(
                padding: EdgeInsets.zero,
                child: messageFactory.create(
                  context: context,
                  model: tileModel,
                ),
              );
            } else {
              widget = const Padding(padding: EdgeInsets.only(bottom: 8.0));
            }
            return widget;
          },
          childCount: _computeActualChildCount(widget.messagesBundle.length),
          findChildIndexCallback: (Key key) {
            if (key is ValueKey<int>) {
              return widget.messagesBundle.indexOf(key.value);
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }
}
