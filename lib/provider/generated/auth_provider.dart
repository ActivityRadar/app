import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';

class AuthProvider {
  /// Login
  static Future<LoginTokenBody> login({required LoginBody data}) async {
    final responseBody = await BackendService.instance.sendRequest(
        HttpMethod.post, "/auth/token",
        body: data.toJson(),
        additionalHeaders: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encodeToJson: false);
    return LoginTokenBody.fromJson(responseBody);
  }

  /// Get New Access Token
  static Future<AccessTokenBody> getNewAccessToken(
      {required String refreshToken}) async {
    final Map<String, dynamic> __q = {"refresh_token": refreshToken.toString()};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.post, "/auth/refresh", queryParams: __q);
    return AccessTokenBody.fromJson(responseBody);
  }

  /// Logout
  static Future<void> logout() async {
    await BackendService.instance.sendRequest(HttpMethod.post, "/auth/logout");
  }
}
