import 'package:coreui/coreui.dart' as tg;
import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';
import 'package:feature_wallpapers_impl/feature_wallpapers_impl.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/wallpaper_list_page.dart';
import 'package:feature_wallpapers_impl/src/screen/wallpaper_list/wallpaper_list_view_model.dart';
import 'package:feature_wallpapers_impl/src/tile/model/model.dart';
import 'package:feature_wallpapers_impl/src/tile/widget/background_wallpaper_tile_factory_delegate.dart';
import 'package:feature_wallpapers_impl/src/tile/widget/bottom_group_tile_factory_delegate.dart';
import 'package:feature_wallpapers_impl/src/tile/widget/fill_wallpaper_tile_factory_delegate.dart';
import 'package:feature_wallpapers_impl/src/tile/widget/pattern_wallpaper_tile_factory_delegate.dart';
import 'package:feature_wallpapers_impl/src/tile/widget/top_group_tile_factory_delegate.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

class WallpapersListScreenFactory implements IWallpapersListScreenFactory {
  WallpapersListScreenFactory({
    required WallpapersFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final WallpapersFeatureDependencies _dependencies;

  @override
  Widget create() {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<ILocalizationManager>(
          create: (BuildContext context) => _dependencies.localizationManager,
        ),
        Provider<TileFactory>(
          create: (BuildContext context) {
            return TileFactory(
              delegates: <Type, ITileFactoryDelegate<ITileModel>>{
                BackgroundWallpaperTileModel:
                    BackgroundWallpaperTileFactoryDelegate(
                  imageWidgetFactory: tg.ImageWidgetFactory(
                    fileDownloader: _dependencies.fileDownloader,
                  ),
                ),
                PatternWallpaperTileModel: PatternWallpaperTileFactoryDelegate(
                  imageWidgetFactory: tg.ImageWidgetFactory(
                    fileDownloader: _dependencies.fileDownloader,
                  ),
                  onTap: (PatternWallpaperTileModel model) {
                    // TODO temporary
                    _dependencies.chatBackgroundManager
                        .setActiveBackground(model.backgroundId);
                  },
                ),
                FillWallpaperTileModel: FillWallpaperTileFactoryDelegate(
                  onTap: (FillWallpaperTileModel model) {
                    // TODO temporary
                    _dependencies.chatBackgroundManager
                        .setActiveBackground(model.backgroundId);
                  },
                ),
                TopGroupTileModel: TopGroupTileFactoryDelegate(
                  localizationManager: _dependencies.localizationManager,
                ),
                BottomGroupTileModel: BottomGroupTileFactoryDelegate(
                  localizationManager: _dependencies.localizationManager,
                ),
              },
            );
          },
        ),
        Provider<tg.TgAppBarFactory>(
          create: (BuildContext context) =>
              tg.TgAppBarFactory.withConnectionStateProvider(
            _dependencies.connectionStateProvider,
          ),
        ),
        Provider<WallpaperListViewModel>(
          create: (BuildContext context) => WallpaperListViewModel(
            backgroundRepository: _dependencies.backgroundRepository,
          ),
          dispose: (_, WallpaperListViewModel value) {
            value.dispose();
          },
        ),
      ],
      child: const WallpaperListPage(),
    );
  }
}
