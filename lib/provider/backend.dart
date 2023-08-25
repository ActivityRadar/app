import 'dart:async';
import 'dart:convert';

import 'package:app/model/generated.dart';
import 'package:app/provider/generated/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TokenManager {
  static const storage = FlutterSecureStorage();

  static const String tokenKey = "token";
  static const String refreshTokenKey = "refreshToken";

  static final TokenManager _instance = TokenManager._internal();
  static TokenManager get instance => _instance;

  TokenManager._internal();

  String getKey(bool refresh, {bool time = false}) {
    return "${refresh ? refreshTokenKey : tokenKey}${time ? "Time" : ""}";
  }

  Future<String?> getToken({bool refresh = false}) async {
    return await storage.read(key: getKey(refresh));
  }

  Future<void> setToken(String? token, {bool refresh = false}) async {
    await storage.write(key: getKey(refresh), value: token);
    await storage.write(
        key: getKey(refresh, time: true),
        value: DateTime.now().toIso8601String());
  }

  Future<void> deleteToken({bool refresh = false}) async {
    await storage.write(key: getKey(refresh), value: null);
    await storage.write(key: getKey(refresh, time: true), value: null);
  }

  Future<DateTime?> lastSetTime({bool refresh = false}) async {
    final string = await storage.read(key: getKey(refresh, time: true));
    if (string != null) {
      return DateTime.parse(string);
    }
    return null;
  }
}

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  static SessionManager get instance => _instance;

  static const Duration accessTokenExpireDuration = Duration(minutes: 20);
  static const Duration refreshTokenExpiryDuration = Duration(days: 30);

  SessionManager._internal();

  Timer? _timer;

  Future<bool> isLoggedIn() async {
    final DateTime? lastLoginTime =
        await TokenManager.instance.lastSetTime(refresh: true);

    if (lastLoginTime == null ||
        lastLoginTime
            .add(refreshTokenExpiryDuration)
            .isBefore(DateTime.now())) {
      print("not logged in or refresh expired");
      // force a login?
      return false;
    }
    return true;
  }

  /// returns true if login required
  Future<void> startSession() async {
    final DateTime? lastRefreshTime = await TokenManager.instance.lastSetTime();
    if (lastRefreshTime == null ||
        lastRefreshTime
            .add(accessTokenExpireDuration)
            .isBefore(DateTime.now())) {
      AuthService.refreshAccessToken();
    }

    // timer that regularly refreshes the access token
    _timer = Timer.periodic(accessTokenExpireDuration, (timer) async {
      try {
        await AuthService.refreshAccessToken();
      } catch (e) {
        // refresh token is outdated, user logged into different device or got banned
        // _timer!.cancel();
      }
    });
  }

  Future endSession() async {
    _timer?.cancel();
  }
}

enum HttpMethod { get, post, put, delete }

class BackendService {
  final client = http.Client();
  final String apiKey = "";
  final String host = "test.activity-radar.com";
  final String scheme = "https";

  static final BackendService _instance = BackendService._internal();
  static BackendService get instance => _instance;
  BackendService._internal();

  Future<Map<String, String>> getHeaders(
      Map<String, String>? additionalHeaders) async {
    var headers = {
      'Access-Control-Allow-Origin': "*",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    String? authToken = await TokenManager.instance.getToken();
    if (authToken != null) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  Future<dynamic> sendRequest(HttpMethod method, String path,
      {Object? body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? additionalHeaders,
      bool encodeToJson = true,
      bool decodeFromJson = true}) async {
    Uri url = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParams ?? {});
    Map<String, String> headers = await getHeaders(additionalHeaders);

    if (encodeToJson && body != null) {
      body = jsonEncode(body);
    }

    Future<http.Response> request;
    switch (method) {
      case HttpMethod.get:
        request = client.get(url, headers: headers);
      case HttpMethod.post:
        request = client.post(url, body: body, headers: headers);
      case HttpMethod.put:
        request = client.put(url, body: body, headers: headers);
      case HttpMethod.delete:
        request = client.delete(url, body: body, headers: headers);
      default:
        throw Exception();
    }
    final response = await request;

    switch (response.statusCode) {
      case (200):
        if (decodeFromJson) {
          return jsonDecode(utf8.decode(response.bodyBytes));
        }
        return response;
      case (307):
        print("Temporary redirect!");
        print(response.body);
      case (401):
        print("Not authorized!");
      default:
        throw Exception(
            'Request failed! Code ${response.statusCode}, Message: ${response.body}');
    }
  }
}

class AuthService {
  static Future<bool> login(String username, String password) async {
    try {
      final authResponse = await AuthProvider.login(
          data: LoginBody(username: username, password: password));

      await TokenManager.instance.setToken(authResponse.accessToken);
      await TokenManager.instance
          .setToken(authResponse.refreshToken, refresh: true);
      return true;
    } catch (e) {
      print("Login failed!");
      print(e);
      return false;
    }
  }

  static Future refreshAccessToken() async {
    final refreshToken = await TokenManager.instance.getToken(refresh: true);
    final AccessTokenBody response =
        await AuthProvider.getNewAccessToken(refreshToken: refreshToken!);
    await TokenManager.instance.setToken(response.accessToken);
  }

  static Future logout() async {
    await AuthProvider.logout();
    await TokenManager.instance.deleteToken();
    await TokenManager.instance.deleteToken(refresh: true);
  }

  static Future<bool> changePassword(ChangePasswordForm passwordBody) async {
    try {
      await BackendService.instance.sendRequest(
        HttpMethod.put,
        "/users/me/change_password",
        body: passwordBody.toJson(),
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void changeEmail() {}
}

class UserService {
  static String prefix = "/users";

  /// Returns the id of the newly created user.
  // TODO: deprecated
  static Future<String> create(UserApiIn userIn) async {
    var body = userIn.toJson();
    Map<String, dynamic> responseBody = await BackendService.instance
        .sendRequest(HttpMethod.post, "$prefix/", body: body);

    return responseBody["id"];
  }

  // TODO: deprecated
  static Future<UserApiOut> getUserInfo(String id) async {
    final q = {"q": id};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "$prefix/id", queryParams: q);

    return UserApiOut.fromJson(responseBody[0]);
  }

  // TODO: deprecated
  static Future<List<UserApiOut>> getInfoBulk(List<String> ids) async {
    final q = {"q": ids};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "$prefix/id", queryParams: q);

    return responseBody.map((info) => UserApiOut.fromJson(info)).toList();
  }

  // TODO: deprecated
  static Future<UserDetailed> getCurrentUserInfo() async {
    final responseBody =
        await BackendService.instance.sendRequest(HttpMethod.get, "$prefix/me");

    return UserDetailed.fromJson(responseBody);
  }
}

class LocationService {
  static String prefix = "/locations";

  // TODO: deprecated
  void createLocation(LocationNew location) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "$prefix/", body: location.toJson());
  }

  void deleteLocation() {}

  // TODO: deprecated
  Future<LocationDetailedApi> getDetails(String locationId) async {
    return LocationDetailedApi.fromJson(
        await BackendService.instance.sendRequest(
      HttpMethod.get,
      "$prefix/$locationId",
    ));
  }

  // TODO: deprecated
  Future<List<LocationShortApi>> getInBoundingBox(GeoJsonLocation southWest,
      GeoJsonLocation northEast, String activity) async {
    Map<String, dynamic> queryParams = {
      "south": southWest.coordinates[1].toString(),
      "north": northEast.coordinates[1].toString(),
      "west": southWest.coordinates[0].toString(),
      "east": northEast.coordinates[0].toString(),
      "activities": [activity]
    };

    List<dynamic> res = await BackendService.instance
        .sendRequest(HttpMethod.get, "$prefix/bbox", queryParams: queryParams);

    return res.map((loc) => LocationShortApi.fromJson(loc)).toList();
  }

  // TODO: deprecated
  Future<List<LocationDetailedApi>> getAroundCenter(GeoJsonLocation center,
      {String? activity}) async {
    final List<dynamic> res = await BackendService.instance
        .sendRequest(HttpMethod.get, "$prefix/around", queryParams: {
      "long": center.coordinates[0].toString(),
      "lat": center.coordinates[1].toString(),
      if (activity != null) "activities": [activity],
    });

    print(res);

    List<LocationDetailedApi> result =
        res.map((loc) => LocationDetailedApi.fromJson(loc)).toList();

    print(result.length);
    print(result[0]);

    return result;
  }
}

class ReviewService {
  void createReview() {}

  void editReview() {}

  void deleteReview() {}

  void reportReview() {}

  void getReviews() {}
}

class ProfilePhotoService {
  static String prefix = "/users/me/photo";

  Future<http.Response> create(String path) async {
    return await BackendService.instance.sendRequest(HttpMethod.post, prefix,
        body: PhotoUrl(url: path).toJson());
  }

  Future<http.Response> delete() async {
    return await BackendService.instance.sendRequest(HttpMethod.delete, prefix);
  }
}

class LocationPhotoService {
  static String _prefix(String id) {
    return "/locations/$id/photos/";
  }

  Future<void> create(String path, String locationId) async {
    await BackendService.instance.sendRequest(
        HttpMethod.post, _prefix(locationId),
        body: PhotoUrl(url: path).toJson());
  }

  Future<http.Response> delete(String photoId, String locationId) async {
    return await BackendService.instance.sendRequest(
      HttpMethod.delete,
      "${_prefix(locationId)}/$photoId",
    );
  }
}
