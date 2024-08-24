import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

abstract class IMessageSender {
  Future<void> sendText({
    required int chatId,
    required String text,
    required int replyToMessageId,
  });
  Future<void> sendImage({
    required int chatId,
    required String path,
    required int replyToMessageId,
  });
}

class MessageSender implements IMessageSender {
  MessageSender({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<void> sendText({required int chatId, required String text,int replyToMessageId=0}) {
    return _functionExecutor.send<td.Message>(
      td.SendMessage(
        chatId: chatId,
        replyToMessageId: replyToMessageId,
        messageThreadId: 0,
        inputMessageContent: td.InputMessageText(
          clearDraft: true,
          disableWebPagePreview: false,
          text: td.FormattedText(text: text, entities: const <td.TextEntity>[]),
        ),
      ),
    );
  }

  @override
  Future<void> sendImage({required int chatId, required String path, required int replyToMessageId}) {
    return _functionExecutor.send<td.Message>(
      td.SendMessage(
        chatId: chatId,
        replyToMessageId: replyToMessageId,
        messageThreadId: 0,
        inputMessageContent: td.InputMessagePhoto(photo: td.InputFileLocal(path: path), addedStickerFileIds: [], width: 720, height: 1080, selfDestructTime: 0, hasSpoiler: true
        ),
      ),
    );
  }
}
