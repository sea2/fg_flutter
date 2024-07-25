import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:localization_api/localization_api.dart';
import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:tile/tile.dart';

import 'chat_forum_view_model.dart';

@scope
abstract class IChatForumScreenScopeDelegate implements ScopeDisposer {
  ChatForumViewModel getChatForumViewModel();

  IStringsProvider getStringsProvider();

  TileFactory getTopicsTileFactory();
}
