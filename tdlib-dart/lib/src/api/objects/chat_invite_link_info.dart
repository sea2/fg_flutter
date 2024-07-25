import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Contains information about a chat invite link
@immutable
class ChatInviteLinkInfo extends TdObject {
  const ChatInviteLinkInfo({
    required this.chatId,
    required this.accessibleFor,
    required this.type,
    required this.title,
    this.photo,
    required this.description,
    required this.memberCount,
    required this.memberUserIds,
    required this.createsJoinRequest,
    required this.isPublic,
  });

  /// [chatId] Chat identifier of the invite link; 0 if the user has no access
  /// to the chat before joining
  final int chatId;

  /// [accessibleFor] If non-zero, the amount of time for which read access to
  /// the chat will remain available, in seconds
  final int accessibleFor;

  /// [type] Type of the chat
  final ChatType type;

  /// [title] Title of the chat
  final String title;

  /// [photo] Chat photo; may be null
  final ChatPhotoInfo? photo;

  /// param_[description] Chat description
  final String description;

  /// [memberCount] Number of members in the chat
  final int memberCount;

  /// [memberUserIds] User identifiers of some chat members that may be known to
  /// the current user
  final List<int> memberUserIds;

  /// [createsJoinRequest] True, if the link only creates join request
  final bool createsJoinRequest;

  /// [isPublic] True, if the chat is a public supergroup or channel, i.e. it
  /// has a username or it is a location-based supergroup
  final bool isPublic;

  static const String constructor = 'chatInviteLinkInfo';

  static ChatInviteLinkInfo? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return ChatInviteLinkInfo(
      chatId: json['chat_id'],
      accessibleFor: json['accessible_for'],
      type: ChatType.fromJson(json['type'])!,
      title: json['title'],
      photo: ChatPhotoInfo.fromJson(json['photo']),
      description: json['description'],
      memberCount: json['member_count'],
      memberUserIds: List<int>.from(
          (json['member_user_ids'] ?? []).map((item) => item).toList()),
      createsJoinRequest: json['creates_join_request'],
      isPublic: json['is_public'],
    );
  }

  @override
  String getConstructor() => constructor;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'chat_id': chatId,
        'accessible_for': accessibleFor,
        'type': type.toJson(),
        'title': title,
        'photo': photo?.toJson(),
        'description': description,
        'member_count': memberCount,
        'member_user_ids': memberUserIds.map((item) => item).toList(),
        'creates_join_request': createsJoinRequest,
        'is_public': isPublic,
        '@type': constructor,
      };

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
