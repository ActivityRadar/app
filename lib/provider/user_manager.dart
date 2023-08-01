import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class UserInfoManager {
  static Map<String, UserApiOut> _storage = {};

  static final UserInfoManager _instance = UserInfoManager._internal();
  static UserInfoManager get instance => _instance;
  UserInfoManager._internal();

  Future<UserApiOut> getUserInfo(String id) async {
    if (!_storage.containsKey(id)) {
      final u = await UserService.getUserInfo(id);
      _storage[id] = u;
    }

    return _storage[id]!;
  }
}
