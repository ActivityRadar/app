import 'dart:convert';

import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/generated/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static const String userInfo = "userInfo";
  static const String boundsSouthWest = "mapBoundsSW";
  static const String boundsNorthEast = "mapBoundsNE";
}

class AppState extends ChangeNotifier {
  UserDetailed? _currentUser;

  UserDetailed? get currentUser => _currentUser;

  final Locale _locale = const Locale("de");

  LatLngBounds _mapPosition =
      LatLngBounds(const LatLng(52.67, 12.04), const LatLng(53.3, 12.74));

  LatLngBounds get mapPosition => _mapPosition;
  set mapPosition(LatLngBounds b) {
    print("set to $b");
    _mapPosition = b;
  }

  double zoom = 13;
  LatLng center = const LatLng(52.9, 12.5);

  Future<void> updateUserInfo() async {
    _currentUser = await UsersProvider.getThisUser();
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool get isLoggedIn {
    return currentUser != null;
  }

  bool get isAllowedToCreateLocation {
    return currentUser == null ? false : (currentUser!.trustScore >= 100);
  }

  void loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(StorageKeys.boundsSouthWest)) {
      LatLng southWest = toLatLng(GeoJsonLocation.fromJson(
          jsonDecode(prefs.getString(StorageKeys.boundsSouthWest)!)));
      LatLng northEast = toLatLng(GeoJsonLocation.fromJson(
          jsonDecode(prefs.getString(StorageKeys.boundsNorthEast)!)));

      _mapPosition = LatLngBounds(southWest, northEast);
    }

    if (prefs.containsKey(StorageKeys.userInfo)) {
      _currentUser = UserDetailed.fromJson(
          jsonDecode(prefs.getString(StorageKeys.userInfo)!));
    }
  }

  void saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentUser != null) {
      await prefs.setString(
          StorageKeys.userInfo, jsonEncode(_currentUser!.toJson()));
    } else {
      await prefs.remove(StorageKeys.userInfo);
    }

    await prefs.setString(StorageKeys.boundsSouthWest,
        jsonEncode(toLongLat(_mapPosition.southWest).toJson()));
    await prefs.setString(StorageKeys.boundsNorthEast,
        jsonEncode(toLongLat(_mapPosition.northEast).toJson()));
  }
}
