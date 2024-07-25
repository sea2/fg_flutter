import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Returns favorite stickers
/// Returns [Stickers]
@immutable
class GetFavoriteStickers extends TdFunction {
  const GetFavoriteStickers();

  static const String constructor = 'getFavoriteStickers';

  @override
  String getConstructor() => constructor;

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        '@type': constructor,
      };

  @override
  bool operator ==(Object other) => overriddenEquality(other);

  @override
  int get hashCode => overriddenHashCode;
}
