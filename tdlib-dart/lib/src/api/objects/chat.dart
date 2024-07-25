import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// A chat. (Can be a private chat, basic group, supergroup, or secret chat)
@immutable
class Chat extends TdObject {
  const Chat({
    required this.id,
    required this.type,
    required this.title,
    this.photo,
    required this.permissions,
    this.lastMessage,
    required this.positions,
    this.messageSenderId,
    required this.hasProtectedContent,
    required this.isTranslatable,
    required this.isMarkedAsUnread,
    required this.isBlocked,
    required this.hasScheduledMessages,
    required this.canBeDeletedOnlyForSelf,
    required this.canBeDeletedForAllUsers,
    required this.canBeReported,
    required this.defaultDisableNotification,
    required this.unreadCount,
    required this.lastReadInboxMessageId,
    required this.lastReadOutboxMessageId,
    required this.unreadMentionCount,
    required this.unreadReactionCount,
    required this.notificationSettings,
    required this.availableReactions,
    required this.messageAutoDeleteTime,
    required this.themeName,
    this.actionBar,
    required this.videoChat,
    this.pendingJoinRequests,
    required this.replyMarkupMessageId,
    this.draftMessage,
    required this.clientData,
  });

  /// [id] Chat unique identifier
  final int id;

  /// [type] Type of the chat
  final ChatType type;

  /// [title] Chat title
  final String title;

  /// [photo] Chat photo; may be null
  final ChatPhotoInfo? photo;

  /// [permissions] Actions that non-administrator chat members are allowed to
  /// take in the chat
  final ChatPermissions permissions;

  /// [lastMessage] Last message in the chat; may be null
  final Message? lastMessage;

  /// [positions] Positions of the chat in chat lists
  final List<ChatPosition> positions;

  /// [messageSenderId] Identifier of a user or chat that is selected to send
  /// messages in the chat; may be null if the user can't change message sender
  final MessageSender? messageSenderId;

  /// [hasProtectedContent] True, if chat content can't be saved locally,
  /// forwarded, or copied
  final bool hasProtectedContent;

  /// [isTranslatable] True, if translation of all messages in the chat must be
  /// suggested to the user
  final bool isTranslatable;

  /// [isMarkedAsUnread] True, if the chat is marked as unread
  final bool isMarkedAsUnread;

  /// [isBlocked] True, if the chat is blocked by the current user and private
  /// messages from the chat can't be received
  final bool isBlocked;

  /// [hasScheduledMessages] True, if the chat has scheduled messages
  final bool hasScheduledMessages;

  /// [canBeDeletedOnlyForSelf] True, if the chat messages can be deleted only
  /// for the current user while other users will continue to see the messages
  final bool canBeDeletedOnlyForSelf;

  /// [canBeDeletedForAllUsers] True, if the chat messages can be deleted for
  /// all users
  final bool canBeDeletedForAllUsers;

  /// [canBeReported] True, if the chat can be reported to Telegram moderators
  /// through reportChat or reportChatPhoto
  final bool canBeReported;

  /// [defaultDisableNotification] Default value of the disable_notification
  /// parameter, used when a message is sent to the chat
  final bool defaultDisableNotification;

  /// [unreadCount] Number of unread messages in the chat
  final int unreadCount;

  /// [lastReadInboxMessageId] Identifier of the last read incoming message
  final int lastReadInboxMessageId;

  /// [lastReadOutboxMessageId] Identifier of the last read outgoing message
  final int lastReadOutboxMessageId;

  /// [unreadMentionCount] Number of unread messages with a mention/reply in the
  /// chat
  final int unreadMentionCount;

  /// [unreadReactionCount] Number of messages with unread reactions in the chat
  final int unreadReactionCount;

  /// [notificationSettings] Notification settings for the chat
  final ChatNotificationSettings notificationSettings;

  /// [availableReactions] Types of reaction, available in the chat
  final ChatAvailableReactions availableReactions;

  /// [messageAutoDeleteTime] Current message auto-delete or self-destruct timer
  /// setting for the chat, in seconds; 0 if disabled. Self-destruct timer in
  /// secret chats starts after the message or its content is viewed.
  /// Auto-delete timer in other chats starts from the send date
  final int messageAutoDeleteTime;

  /// [themeName] If non-empty, name of a theme, set for the chat
  final String themeName;

  /// [actionBar] Information about actions which must be possible to do through
  /// the chat action bar; may be null
  final ChatActionBar? actionBar;

  /// [videoChat] Information about video chat of the chat
  final VideoChat videoChat;

  /// [pendingJoinRequests] Information about pending join requests; may be null
  final ChatJoinRequestsInfo? pendingJoinRequests;

  /// [replyMarkupMessageId] Identifier of the message from which reply markup
  /// needs to be used; 0 if there is no default custom reply markup in the chat
  final int replyMarkupMessageId;

  /// [draftMessage] A draft of a message in the chat; may be null
  final DraftMessage? draftMessage;

  /// [clientData] Application-specific data associated with the chat. (For
  /// example, the chat scroll position or local chat notification settings can
  /// be stored here.) Persistent if the message database is used
  final String clientData;

  static const String constructor = 'chat';

  static Chat? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return Chat(
      id: json['id'],
      type: ChatType.fromJson(json['type'])!,
      title: json['title'],
      photo: ChatPhotoInfo.fromJson(json['photo']),
      permissions: ChatPermissions.fromJson(json['permissions'])!,
      lastMessage: Message.fromJson(json['last_message']),
      positions: List<ChatPosition>.from((json['positions'] ?? [])
          .map((item) => ChatPosition.fromJson(item))
          .toList()),
      messageSenderId: MessageSender.fromJson(json['message_sender_id']),
      hasProtectedContent: json['has_protected_content'],
      isTranslatable: json['is_translatable'],
      isMarkedAsUnread: json['is_marked_as_unread'],
      isBlocked: json['is_blocked'],
      hasScheduledMessages: json['has_scheduled_messages'],
      canBeDeletedOnlyForSelf: json['can_be_deleted_only_for_self'],
      canBeDeletedForAllUsers: json['can_be_deleted_for_all_users'],
      canBeReported: json['can_be_reported'],
      defaultDisableNotification: json['default_disable_notification'],
      unreadCount: json['unread_count'],
      lastReadInboxMessageId: json['last_read_inbox_message_id'],
      lastReadOutboxMessageId: json['last_read_outbox_message_id'],
      unreadMentionCount: json['unread_mention_count'],
      unreadReactionCount: json['unread_reaction_count'],
      notificationSettings:
          ChatNotificationSettings.fromJson(json['notification_settings'])!,
      availableReactions:
          ChatAvailableReactions.fromJson(json['available_reactions'])!,
      messageAutoDeleteTime: json['message_auto_delete_time'],
      themeName: json['theme_name'],
      actionBar: ChatActionBar.fromJson(json['action_bar']),
      videoChat: VideoChat.fromJson(json['video_chat'])!,
      pendingJoinRequests:
          ChatJoinRequestsInfo.fromJson(json['pending_join_requests']),
      replyMarkupMessageId: json['reply_markup_message_id'],
      draftMessage: DraftMessage.fromJson(json['draft_message']),
      clientData: json['client_data'],
    );
  }

  @override
  String getConstructor() => constructor;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'type': type.toJson(),
        'title': title,
        'photo': photo?.toJson(),
        'permissions': permissions.toJson(),
        'last_message': lastMessage?.toJson(),
        'positions': positions.map((item) => item.toJson()).toList(),
        'message_sender_id': messageSenderId?.toJson(),
        'has_protected_content': hasProtectedContent,
        'is_translatable': isTranslatable,
        'is_marked_as_unread': isMarkedAsUnread,
        'is_blocked': isBlocked,
        'has_scheduled_messages': hasScheduledMessages,
        'can_be_deleted_only_for_self': canBeDeletedOnlyForSelf,
        'can_be_deleted_for_all_users': canBeDeletedForAllUsers,
        'can_be_reported': canBeReported,
        'default_disable_notification': defaultDisableNotification,
        'unread_count': unreadCount,
        'last_read_inbox_message_id': lastReadInboxMessageId,
        'last_read_outbox_message_id': lastReadOutboxMessageId,
        'unread_mention_count': unreadMentionCount,
        'unread_reaction_count': unreadReactionCount,
        'notification_settings': notificationSettings.toJson(),
        'available_reactions': availableReactions.toJson(),
        'message_auto_delete_time': messageAutoDeleteTime,
        'theme_name': themeName,
        'action_bar': actionBar?.toJson(),
        'video_chat': videoChat.toJson(),
        'pending_join_requests': pendingJoinRequests?.toJson(),
        'reply_markup_message_id': replyMarkupMessageId,
        'draft_message': draftMessage?.toJson(),
        'client_data': clientData,
        '@type': constructor,
      };

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
