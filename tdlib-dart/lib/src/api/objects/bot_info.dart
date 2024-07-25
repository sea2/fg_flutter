import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Contains information about a bot
@immutable
class BotInfo extends TdObject {
  const BotInfo({
    required this.shareText,
    required this.description,
    this.photo,
    this.animation,
    this.menuButton,
    required this.commands,
    this.defaultGroupAdministratorRights,
    this.defaultChannelAdministratorRights,
  });

  /// [shareText] The text that is shown on the bot's profile page and is sent
  /// together with the link when users share the bot
  final String shareText;

  /// param_[description] The text shown in the chat with the bot if the chat is
  /// empty
  final String description;

  /// [photo] Photo shown in the chat with the bot if the chat is empty; may be
  /// null
  final Photo? photo;

  /// [animation] Animation shown in the chat with the bot if the chat is empty;
  /// may be null
  final Animation? animation;

  /// [menuButton] Information about a button to show instead of the bot
  /// commands menu button; may be null if ordinary bot commands menu must be
  /// shown
  final BotMenuButton? menuButton;

  /// [commands] List of the bot commands
  final List<BotCommand> commands;

  /// [defaultGroupAdministratorRights] Default administrator rights for adding
  /// the bot to basic group and supergroup chats; may be null
  final ChatAdministratorRights? defaultGroupAdministratorRights;

  /// [defaultChannelAdministratorRights] Default administrator rights for
  /// adding the bot to channels; may be null
  final ChatAdministratorRights? defaultChannelAdministratorRights;

  static const String constructor = 'botInfo';

  static BotInfo? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return BotInfo(
      shareText: json['share_text'],
      description: json['description'],
      photo: Photo.fromJson(json['photo']),
      animation: Animation.fromJson(json['animation']),
      menuButton: BotMenuButton.fromJson(json['menu_button']),
      commands: List<BotCommand>.from((json['commands'] ?? [])
          .map((item) => BotCommand.fromJson(item))
          .toList()),
      defaultGroupAdministratorRights: ChatAdministratorRights.fromJson(
          json['default_group_administrator_rights']),
      defaultChannelAdministratorRights: ChatAdministratorRights.fromJson(
          json['default_channel_administrator_rights']),
    );
  }

  @override
  String getConstructor() => constructor;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'share_text': shareText,
        'description': description,
        'photo': photo?.toJson(),
        'animation': animation?.toJson(),
        'menu_button': menuButton?.toJson(),
        'commands': commands.map((item) => item.toJson()).toList(),
        'default_group_administrator_rights':
            defaultGroupAdministratorRights?.toJson(),
        'default_channel_administrator_rights':
            defaultChannelAdministratorRights?.toJson(),
        '@type': constructor,
      };

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
