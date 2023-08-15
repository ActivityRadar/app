import 'package:app/model/generated.dart';
import 'package:app/provider/generated/users_provider.dart';

class UserInfoManager {
  static final Map<String, UserApiOut> _storage = {};

  static final UserInfoManager _instance = UserInfoManager._internal();
  static UserInfoManager get instance => _instance;
  UserInfoManager._internal();

  Future<UserApiOut> getUserInfo(String id, {bool force = false}) async {
    if (!_storage.containsKey(id) || force) {
      final u = await UsersProvider.getUserInfos(q: [id]);
      _storage[id] = u.first;
    } else {
      print("User not found!");
    }

    return _storage[id]!;
  }

  Future<void> fetchInfoList(List<String> ids, {bool force = false}) async {
    List<String> notStored = [];
    for (var id in ids) {
      if (!_storage.containsKey(id) || force) {
        notStored.add(id);
      }
    }

    if (notStored.isNotEmpty) {
      List<UserApiOut> us = await UsersProvider.getUserInfos(q: notStored);
      for (var u in us) {
        _storage[u.id] = u;
      }
    }
  }

  Future<List<UserApiOut>> getInfoList(List<String> ids,
      {bool force = false}) async {
    await fetchInfoList(ids, force: force);
    return ids.map((id) => _storage[id]!).toList();
  }
}
