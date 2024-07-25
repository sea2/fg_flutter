import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:flutter/material.dart';

class ChatHeaderInfoFactory implements IChatHeaderInfoFactory {
  ChatHeaderInfoFactory({
    required tg.ConnectionStateWidgetFactory connectionStateWidgetFactory,
    required tg.AvatarWidgetFactory avatarWidgetFactory,
  })  : _avatarWidgetFactory = avatarWidgetFactory,
        _connectionStateWidgetFactory = connectionStateWidgetFactory;

  final tg.ConnectionStateWidgetFactory _connectionStateWidgetFactory;
  final tg.AvatarWidgetFactory _avatarWidgetFactory;

  @override
  Widget create({
    required BuildContext context,
    required ChatHeaderInfo info,
    void Function()? onProfileTap,
  }) {
    return ListTile(
      onTap: onProfileTap,
      contentPadding: EdgeInsets.zero,
      leading: tg.AvatarWidget(
        factory: _avatarWidgetFactory,
        avatar: info.avatar,
      ),
      title: Text(
        info.title,
        maxLines: 1,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: _connectionStateWidgetFactory.create(context, (_) {
          return Text(
            info.subtitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white54),
          );
        }),
      ),
    );
  }
}
