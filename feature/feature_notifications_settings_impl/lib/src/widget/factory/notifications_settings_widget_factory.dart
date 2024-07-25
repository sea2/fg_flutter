import 'package:coreui/coreui.dart' as tg;
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_notifications_settings_impl/src/screen/notifications_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class NotificationsSettingsWidgetFactory
    implements INotificationsSettingsWidgetFactory {
  NotificationsSettingsWidgetFactory({required this.dependencies});

  final NotificationsSettingsFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
            value: dependencies.localizationManager,
          ),
          Provider<tg.ConnectionStateWidgetFactory>.value(
            value: tg.ConnectionStateWidgetFactory(
              connectionStateProvider: dependencies.connectionStateProvider,
            ),
          ),
        ],
        child: const NotificationsSettingsPage(),
      );
}
