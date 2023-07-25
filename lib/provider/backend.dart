import 'dart:async';
import 'dart:convert';

import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

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

  Future<http.Response> sendRequest(String command, String path,
      {Object? body,
      Map<String, dynamic>? queryParams,
      Map<String, String>? additionalHeaders}) async {
    if (command != "GET" && body == null) {
      throw Exception();
    }

    Uri url = Uri(
        scheme: scheme,
        host: host,
        path: path,
        queryParameters: queryParams ?? {});
    Map<String, String> headers = await getHeaders(additionalHeaders);

    Future<http.Response> request;
    switch (command) {
      case "GET":
        request = client.get(url, headers: headers);
      case "POST":
        request = client.post(url, body: body, headers: headers);
      case "PUT":
        request = client.put(url, body: body, headers: headers);
      case "DELETE":
        request = client.delete(url, body: body, headers: headers);
      default:
        throw Exception();
    }
    final response = await request;

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception(
          'Request failed! Code ${response.statusCode}, Message: ${response.body}');
    }
  }

  void authenticate() {}
}

class AuthService {
  static Future<bool> login(String username, String password) async {
    Map<String, String> body = {"username": username, "password": password};

    try {
      http.Response res = await BackendService.instance.sendRequest(
          "POST", "/auth/token", body: body, additionalHeaders: {
        "Content-Type": "application/x-www-form-urlencoded"
      });

      String token = jsonDecode(res.body)["access_token"];
      await storage.write(key: "token", value: token);
      return true;
    } catch (e) {
      print("Login failed!");
      print(e);
      return false;
    }
  }

  void changePassword() {}

  void changeEmail() {}
}

class UserService {
  void createUser() {}

  void deleteUser() {}

  void changeUsername() {}

  void changeDisplayName() {}

  void findUser() {}

  void getUserInfo() {}
}

class RelationService {
  void addFriend() {}

  void unfriend() {}

  void getFriends() {}

  void getOpenRequests() {}
}

class LocationService {
  static String prefix = "/locations";

  void createLocation() {}

  void deleteLocation() {}

  Future<http.Response> getDetails(String locationId) async {
    return await BackendService.instance.sendRequest(
      "GET",
      "$prefix/$locationId",
    );
  }

  Future<http.Response> getInBoundingBox(
      LatLngBounds bounds, String activity) async {
    Map<String, dynamic> queryParams = {
      "south": bounds.south.toString(),
      "north": bounds.north.toString(),
      "west": bounds.west.toString(),
      "east": bounds.east.toString(),
      "activities": [activity]
    };

    return await BackendService.instance
        .sendRequest("GET", "$prefix/bbox", queryParams: queryParams);
  }

  void getAroundCenter() {}
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
    return await BackendService.instance
        .sendRequest("POST", prefix, queryParams: {"photo_url": path});
  }

  Future<http.Response> delete() async {
    return await BackendService.instance.sendRequest("DELETE", prefix);
  }
}

class LocationPhotoService {
  static String _prefix(String id) {
    return "/locations/$id/photos/";
  }

  Future<http.Response> create(String path, String locationId) async {
    return await BackendService.instance
        .sendRequest("POST", _prefix(locationId), body: jsonEncode(path));
  }

  Future<http.Response> delete(String locationId, String photoId) async {
    return await BackendService.instance.sendRequest(
        "DELETE", _prefix(locationId),
        queryParams: {"photo_id": photoId});
  }
}
