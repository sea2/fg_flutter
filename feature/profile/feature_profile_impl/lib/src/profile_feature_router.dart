import 'package:feature_shared_media_api/feature_shared_media_api.dart';

abstract class IProfileFeatureRouter {
  void toSharedMedia(SharedContentType type);

  void toQuickNotificationSettings();

  void toChatAdministration(int chatId);

  void toAddNewContact(int userId);
}
