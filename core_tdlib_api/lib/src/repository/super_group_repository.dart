import 'package:td_api/td_api.dart' as td;

abstract class ISuperGroupRepository {
  Future<td.Supergroup> getGroup(int id);

  Future<td.SupergroupFullInfo> getGroupFullInfo(int id);
}
