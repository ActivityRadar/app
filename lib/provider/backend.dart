import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

class BackendService {
  var client = http.Client();
  final String apiKey = "";
  // final String host = "192.168.188.164";
  final String host = "localhost"; // TODO: make this the domain for production
  final int port = 8000;
  final String scheme = "http"; // TODO: make this https for production

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
      Map<String, String>? queryParams,
      Map<String, String>? additionalHeaders}) async {
    if (command != "GET" && body == null) {
      throw Exception();
    }

    Uri url = Uri(
        scheme: scheme,
        host: host,
        port: port,
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
      http.Response res = await BackendService._instance.sendRequest(
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
  void createLocation() {}

  void deleteLocation() {}

  void getInBoundingBox() {}

  void getAroundCenter() {}
}

class ReviewService {
  void createReview() {}

  void editReview() {}

  void deleteReview() {}

  void reportReview() {}

  void getReviews() {}
}


// MyMarker markerFromJson(Map<String, dynamic> json) {
//   var loc = LatLng(
//       json["location"]["coordinates"][1], json["location"]["coordinates"][0]);
//   String id = json["id"];
//
//   return MyMarker(
//       point: loc,
//       width: 20,
//       height: 20,
//       builder: (context) => IconButton(
//             icon: const Icon(Icons.location_pin),
//             onPressed: () {
//               print("marker pressed with id: ${id}");
//               // TODO: open widget and fetch data
//             },
//           ),
//       anchorPos: AnchorPos.align(AnchorAlign.top));
// }
//
// List<MyMarker> parseMarkers(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   return parsed.map<MyMarker>((json) => markerFromJson(json)).toList();
// }
//
// Future<List<MyMarker>> fetchLocations(
//     LatLngBounds bounds, String activity) async {
//   final response = await http.get(
//       Uri(
//           scheme: "http",
//           host: "192.168.188.164",
//           port: 8000,
//           path: '/locations/bbox',
//           queryParameters: {
//             "west": bounds.west.toString(),
//             "east": bounds.east.toString(),
//             "south": bounds.south.toString(),
//             "north": bounds.north.toString(),
//             if (activity.isNotEmpty) "activities": activity
//           }),
//       headers: {
//         'Access-Control-Allow-Origin': "*",
//         'Content-Type': 'application/json',
//         'Accept': '*/*'
//       });
//   if (response.statusCode == 200) {
//     return parseMarkers(response.body);
//   } else {
//     throw Exception('Unable to fetch products from the REST API');
//   }
// }
