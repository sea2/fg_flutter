import 'package:td_api/td_api.dart' as td;

abstract class IChatRepository {
  Future<td.Chat> getChat(int id);

  Future<List<td.Chat>> getChats({
    required int offsetChatId,
    required int offsetOrder,
    required int limit,
    required td.ChatList chatList,
  });

  Future<List<td.Chat>> findChats({
    required String query,
  });
}
