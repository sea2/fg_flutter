import 'package:core/core.dart';
import 'package:td_api/td_api.dart' as td;

import 'background_fill.dart';

extension BackgroundFillExt on td.BackgroundFill {
  // todo refactor
  IBackgroundFill toBackgroundFill() {
    final td.BackgroundFill fill = this;
    if (fill is td.BackgroundFillSolid) {
      return BackgroundFillSolid(
        color: fill.color.toColor(),
      );
    } else if (fill is td.BackgroundFillGradient) {
      return BackgroundFillGradient(
        topColor: fill.topColor.toColor(),
        bottomColor: fill.bottomColor.toColor(),
        angle: fill.rotationAngle,
      );
    } else if (fill is td.BackgroundFillFreeformGradient) {
      // todo handle correct color
      return BackgroundFillSolid(
        color: fill.colors[0].toColor(),
      );
    }

    throw StateError('unexpected background $runtimeType');
  }
}
