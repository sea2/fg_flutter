import 'package:flutter/material.dart';

import 'message_popup_listener.dart';
import 'message_popup_menu.dart';
import 'message_popup_menu_impl.dart';
import 'popup_menu_area.dart';

class MessagePopupMenuArea extends StatefulWidget {
  const MessagePopupMenuArea({
    super.key,
    required this.child,
    required this.listener,
    required this.messageId,
    required this.chatId,
  });

  final Widget child;
  final IMessagePopupMenuListener listener;
  final int messageId;
  final int chatId;

  @override
  State<MessagePopupMenuArea> createState() => _MessagePopupMenuAreaState();
}

class _MessagePopupMenuAreaState extends State<MessagePopupMenuArea> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuArea<ItemAction>(
      chatId:widget.chatId,
      messageId: widget.messageId,
      // ignore: always_specify_types
      onTap: (show) {
        final MessagePopupMenuImpl popupMenu =
            MessagePopupMenuImpl(onShow: show);
        widget.listener.onWillShowPopupMenu(widget.messageId, popupMenu);
      },
      onSelected: (ItemAction item) {
        widget.listener.onItemSelected(widget.messageId, item);
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: widget.child,
      ),
    );
  }
}
