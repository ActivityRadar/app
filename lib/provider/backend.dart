import 'dart:async';
import 'dart:convert';

import 'package:app/model/generated.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

enum HttpMethod { get, post, put, delete }

class BackendService {
  var client = http.Client();
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

    String? authToken = await storage.read(key: "token");
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
    if (method != HttpMethod.get && body == null) {
      throw Exception();
    }

    Uri url = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParams ?? {});
    Map<String, String> headers = await getHeaders(additionalHeaders);

    if (encodeToJson) {
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
          return jsonDecode(response.body);
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
    Map<String, String> body = {"username": username, "password": password};

    try {
      Map<String, dynamic> responseBody = await BackendService.instance
          .sendRequest(HttpMethod.post, "/auth/token",
              body: body,
              encodeToJson: false,
              additionalHeaders: {
            "Content-Type": "application/x-www-form-urlencoded",
          });

      String token = responseBody["access_token"];
      await storage.write(key: "token", value: token);
      return true;
    } catch (e) {
      print("Login failed!");
      print(e);
      return false;
    }
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
  static Future<String> create(UserApiIn userIn) async {
    var body = userIn.toJson();
    Map<String, dynamic> responseBody = await BackendService.instance
        .sendRequest(HttpMethod.post, "$prefix/", body: body);

    return responseBody["id"];
  }

  static void deleteUser() {}

  static void changeUsername() {}

  static void changeDisplayName() {}

  static void findUser() {}

  static Future<UserApiOut> getUserInfo(String id) async {
    final q = {"q": id};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "$prefix/id", queryParams: q);

    return UserApiOut.fromJson(responseBody[0]);
  }

  static Future<List<UserApiOut>> getInfoBulk(List<String> ids) async {
    final q = {"q": ids};
    final responseBody = await BackendService.instance
        .sendRequest(HttpMethod.get, "$prefix/id", queryParams: q);

    return responseBody.map((info) => UserApiOut.fromJson(info)).toList();
  }

  static Future<UserDetailed> getCurrentUserInfo() async {
    final responseBody =
        await BackendService.instance.sendRequest(HttpMethod.get, "$prefix/me");

    return UserDetailed.fromJson(responseBody);
  }
}

class RelationService {
  void addFriend() {}

  void unfriend() {}

  void getFriends() {}

  void getOpenRequests() {}
}

class LocationService {
  static String prefix = "/locations";

  void createLocation(LocationNew location) async {
    await BackendService.instance
        .sendRequest(HttpMethod.post, "$prefix/", body: location.toJson());
  }

  void deleteLocation() {}

  Future<LocationDetailedApi> getDetails(String locationId) async {
    return LocationDetailedApi.fromJson(
        await BackendService.instance.sendRequest(
      HttpMethod.get,
      "$prefix/$locationId",
    ));
  }

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

  Future<http.Response> delete(String locationId, String photoId) async {
    return await BackendService.instance.sendRequest(
      HttpMethod.delete,
      "${_prefix(locationId)}/$photoId",
    );
  }
}
