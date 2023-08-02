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

  Future<void> fetchInfoList(List<String> ids) async {
    List<String> notStored = [];
    for (var id in ids) {
      if (!_storage.containsKey(id)) {
        notStored.add(id);
      }
    }

    if (notStored.isNotEmpty) {
      List<UserApiOut> us = await UserService.getInfoBulk(notStored);
      for (var u in us) {
        _storage[u.id] = u;
      }
    }
  }

  Future<List<UserApiOut>> getInfoList(List<String> ids) async {
    await fetchInfoList(ids);
    return ids.map((id) => _storage[id]!).toList();
  }
}
