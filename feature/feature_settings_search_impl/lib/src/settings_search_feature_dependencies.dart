import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dmg_annotation/dmg_annotation.dart';
import 'package:feature_settings_search_impl/src/settings_search_screen_router.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

export 'settings_search_screen_router.dart';

@immutable
@dependencies
class SettingsSearchFeatureDependencies {
  const SettingsSearchFeatureDependencies({
    required this.stringsProvider,
    required this.router,
    required this.connectionStateProvider,
  });

  final IStringsProvider stringsProvider;

  final ISettingsSearchScreenRouter router;

  final IConnectionStateProvider connectionStateProvider;
}
