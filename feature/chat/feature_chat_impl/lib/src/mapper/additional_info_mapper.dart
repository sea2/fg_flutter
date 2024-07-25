import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:intl/intl.dart';
import 'package:td_api/td_api.dart' as td;

class AdditionalInfoMapper {
  AdditionalInfoMapper({
    required DateParser dateParser,
  }) : _dateParser = dateParser;

  final DateParser _dateParser;
  final DateFormat _format = DateFormat('HH:mm');
  final NumberFormat compatNumberFormat = NumberFormat.compact();

  Future<AdditionalInfo> map(td.Message message) async {
    final DateTime dateTime =
        _dateParser.parseUnixTimeStampToDate(message.date);
    return AdditionalInfo(
      sentDate: _format.format(dateTime),
      viewCount: getViewCount(message),
      authorSignature: getAuthorSignature(message),
      // todo handle read messages
      hasBeenRead: null,
      isEdited: message.editDate > 0,
    );
  }

  String? getAuthorSignature(td.Message message) {
    // todo get signature from forward_info if forwarded
    final String? authorSignature = message.authorSignature;
    if (authorSignature != null && authorSignature.isNotEmpty) {
      return authorSignature;
    }
    return null;
  }

  String? getViewCount(td.Message message) {
    if (message.isChannelPost) {
      final int? viewCount = message.interactionInfo?.viewCount;
      if (viewCount != null) {
        return compatNumberFormat.format(viewCount);
      }
    }

    return null;
  }
}
