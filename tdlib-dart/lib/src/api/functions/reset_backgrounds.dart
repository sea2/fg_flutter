import 'package:meta/meta.dart';
import '../extensions/data_class_extensions.dart';
import '../tdapi.dart';

/// Resets list of installed backgrounds to its default value
/// Returns [Ok]
@immutable
class ResetBackgrounds extends TdFunction {
  const ResetBackgrounds();

  static const String constructor = 'resetBackgrounds';

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
