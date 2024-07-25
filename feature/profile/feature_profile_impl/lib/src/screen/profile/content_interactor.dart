import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:td_api/td_api.dart' as td;
import 'package:tuple/tuple.dart';

class ContentInteractor {
  ContentInteractor({
    required ProfileArgs args,
    required IUserRepository userRepository,
    required IStringsProvider stringsProvider,
    required IChatRepository chatRepository,
    required ISuperGroupRepository superGroupRepository,
    required IBasicGroupRepository basicGroupRepository,
    required IChatMessageRepository messageRepository,
  })  : _args = args,
        _userRepository = userRepository,
        _chatRepository = chatRepository,
        _stringsProvider = stringsProvider,
        _superGroupRepository = superGroupRepository,
        _basicGroupRepository = basicGroupRepository,
        _messageRepository = messageRepository;

  final ProfileArgs _args;
  final IChatMessageRepository _messageRepository;
  final ISuperGroupRepository _superGroupRepository;
  final IBasicGroupRepository _basicGroupRepository;
  final IUserRepository _userRepository;
  final IChatRepository _chatRepository;
  final IStringsProvider _stringsProvider;

  Future<ContentData> getContent() async {
    switch (_args.type) {
      case ProfileType.user:
        return _getUserContent(_args.id);
      case ProfileType.chat:
        return _getChatContent(_args.id);
    }
  }

  Future<ContentData> _getUserContent(int id) async {
    // TODO: implement for user
    return ContentData(
      sharedContent: <SharedContentInfo>[],
      description: 'not implemented for user',
      isMuted: false,
    );
  }

  // todo handle Update*FullInfo events
  Future<ContentData> _getChatContent(int id) async {
    final List<SharedContentInfo> messagesInfo = (await _getMessagesCount())
        .where((Tuple2<SharedContentType, int> element) => element.item2 > 0)
        .map(
          (Tuple2<SharedContentType, int> e) => SharedContentInfo(
            title: _toHumanString(e.item1),
            type: e.item1,
            count: e.item2,
          ),
        )
        .toList();

    final td.Chat chat = await _chatRepository.getChat(_args.id);

    // TODO: replace by map extension
    switch (chat.type.getConstructor()) {
      case td.ChatTypeSecret.constructor:
        {
          return _getContentForUser(
            messagesInfo,
            await _userRepository
                .getUserFullInfo((chat.type as td.ChatTypeSecret).userId),
            chat,
          );
        }
      case td.ChatTypePrivate.constructor:
        {
          return _getContentForUser(
            messagesInfo,
            await _userRepository
                .getUserFullInfo((chat.type as td.ChatTypePrivate).userId),
            chat,
          );
        }
      case td.ChatTypeBasicGroup.constructor:
        {
          return _getContentForBasicGroup(
            messagesInfo,
            await _basicGroupRepository.getGroupFullInfo(
              (chat.type as td.ChatTypeBasicGroup).basicGroupId,
            ),
            chat,
          );
        }
      case td.ChatTypeSupergroup.constructor:
        {
          return _getContentForSupergroup(
            messagesInfo,
            await _superGroupRepository.getGroupFullInfo(
              (chat.type as td.ChatTypeSupergroup).supergroupId,
            ),
            chat,
          );
        }
    }

    throw StateError('unknown chat type ${chat.type.runtimeType}');
  }

  Future<List<Tuple2<SharedContentType, int>>> _getMessagesCount() async {
    final List<Future<Tuple2<SharedContentType, int>>> countsFuture =
        <Future<Tuple2<SharedContentType, int>>>[
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterPhotoAndVideo(),
          )
          .then(
            (int value) =>
                Tuple2<SharedContentType, int>(SharedContentType.media, value),
          ),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterDocument(),
          )
          .then(
            (int value) =>
                Tuple2<SharedContentType, int>(SharedContentType.files, value),
          ),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterUrl(),
          )
          .then(
            (int value) =>
                Tuple2<SharedContentType, int>(SharedContentType.links, value),
          ),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterAudio(),
          )
          .then(
            (int value) =>
                Tuple2<SharedContentType, int>(SharedContentType.music, value),
          ),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterVoiceNote(),
          )
          .then(
            (int value) =>
                Tuple2<SharedContentType, int>(SharedContentType.voice, value),
          ),
      _messageRepository
          .getMessagesCount(
            chatId: _args.id,
            filter: const td.SearchMessagesFilterAnimation(),
          )
          .then(
            (int value) =>
                Tuple2<SharedContentType, int>(SharedContentType.gif, value),
          ),
    ];

    return Future.wait(countsFuture);
  }

  Future<ContentData> _getContentForUser(
    List<SharedContentInfo> messagesInfo,
    td.UserFullInfo userFullInfo,
    td.Chat chat,
  ) async {
    return ContentData(
      // TODO: support formatter text
      description: userFullInfo.bio?.text ?? '',
      sharedContent: messagesInfo,
      isMuted: chat.notificationSettings.muteFor > 0,
    );
  }

  Future<ContentData> _getContentForSupergroup(
    List<SharedContentInfo> messagesInfo,
    td.SupergroupFullInfo supergroupFullInfo,
    td.Chat chat,
  ) async {
    return ContentData(
      description: supergroupFullInfo.description,
      sharedContent: messagesInfo,
      isMuted: chat.notificationSettings.muteFor > 0,
    );
  }

  Future<ContentData> _getContentForBasicGroup(
    List<SharedContentInfo> messagesInfo,
    td.BasicGroupFullInfo basicGroupFullInfo,
    td.Chat chat,
  ) async {
    return ContentData(
      description: basicGroupFullInfo.description,
      sharedContent: messagesInfo,
      // todo extract extension
      isMuted: chat.notificationSettings.muteFor > 0,
    );
  }

  String _toHumanString(SharedContentType type) {
    switch (type) {
      case SharedContentType.media:
        break;
      case SharedContentType.files:
        break;
      case SharedContentType.links:
        return _stringsProvider.sharedLinks;
      case SharedContentType.music:
        break;
      case SharedContentType.voice:
        break;
      case SharedContentType.gif:
        break;
      case SharedContentType.groups:
        break;
    }

    return type.toString().split('.')[1];
  }
}

class ContentData {
  ContentData({
    required this.sharedContent,
    required this.description,
    // todo handle UpdateChatNotificationSettings
    required this.isMuted,
  });

  final List<SharedContentInfo> sharedContent;

  final String description;
  final bool isMuted;
}

class SharedContentInfo {
  SharedContentInfo({
    required this.type,
    required this.count,
    required this.title,
  });

  final SharedContentType type;
  final int count;
  final String title;
}

extension ContentDataExt on ContentData {
  ContentData copy({
    bool? isMuted,
    String? description,
    List<SharedContentInfo>? sharedContent,
  }) {
    return ContentData(
      isMuted: isMuted ?? this.isMuted,
      description: description ?? this.description,
      sharedContent: sharedContent ?? this.sharedContent,
    );
  }
}
