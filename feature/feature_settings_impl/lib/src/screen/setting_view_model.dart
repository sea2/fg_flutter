import 'package:core_arch/core_arch.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:jugger/jugger.dart' as j;

import 'content_state.dart';
import 'settings_screen_content_interactor.dart';

@j.singleton
@j.disposable
class SettingViewModel extends BaseViewModel {
  @j.inject
  SettingViewModel({
    required ISettingsScreenRouter router,
    required SettingsScreenContentInteractor contentInteractor,
  })  : _router = router,
        _contentInteractor = contentInteractor;

  final ISettingsScreenRouter _router;
  final SettingsScreenContentInteractor _contentInteractor;

  Stream<ContentState> get stateStream => _contentInteractor.stateStream;

  void onLogOutTap() => _router.toLogOut();

  void onNotificationsSettingsTap() => _router.toNotificationsSettings();

  void onUsernameTap() => _router.toChangeUsername();

  void onBioTap() => _router.toChangeBio();

  void onPrivacySettingsTap() => _router.toPrivacySettings();

  void onDataSettingsTap() => _router.toDataSettings();

  void onChatSettingsTap() => _router.toChatSettings();

  void onFoldersTap() => _router.toFolders();

  void onSessionsTap() => _router.toSessions();

  @override
  void dispose() {
    _contentInteractor.dispose();
    super.dispose();
  }
}
