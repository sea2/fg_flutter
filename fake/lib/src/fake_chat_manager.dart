import 'dart:async';

import 'package:chat_manager_api/chat_manager_api.dart';

class FakeChatManager implements IChatManager {
  const FakeChatManager({this.createChannelFunction});

  final Future<int> Function(String name, String description)?
      createChannelFunction;

  @override
  Future<void> delete(int chatId) => Completer<void>().future;

  @override
  Future<void> join(int chatId) => Completer<void>().future;

  @override
  Future<void> leave(int chatId) => Completer<void>().future;

  @override
  void markAsClosedChat(int chatId) {}

  @override
  void markAsOpenedChat(int chatId) {}

  @override
  Future<void> muteFor(int chatId, int seconds) => Completer<void>().future;

  @override
  Future<int> createChannel({
    required String name,
    required String description,
  }) {
    if (createChannelFunction != null) {
      return createChannelFunction!.call(name, description);
    }
    return Completer<int>().future;
  }
}
