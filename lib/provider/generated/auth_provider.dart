import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class AuthProvider {
  /// Login
  static Future<AuthTokenBody> login({required LoginBody data}) async {
    final responseBody = await BackendService.instance.sendRequest(
        HttpMethod.post, "/auth/token",
        body: data.toJson(),
        additionalHeaders: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encodeToJson: false);
    return AuthTokenBody.fromJson(responseBody);
  }
}
