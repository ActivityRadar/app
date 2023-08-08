import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class AuthProvider {
  /// Login
  Future<void> login({required LoginBody data}) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "/auth/token", body: data.toJson());
  }
}
