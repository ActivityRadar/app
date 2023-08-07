import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class AppState extends ChangeNotifier {
  UserDetailed? _currentUser;

  UserDetailed? get currentUser => _currentUser;

  Locale _locale = Locale("de");

  void updateUserInfo() async {
    _currentUser = await UserService.getCurrentUserInfo();
  }

  bool get isLoggedIn {
    return currentUser != null;
  }

  bool get isAllowedToCreateLocation {
    return currentUser == null ? false : (currentUser!.trustScore >= 100);
  }

  LatLngBounds _mapPosition =
      LatLngBounds(LatLng(52.67, 12.04), LatLng(53.3, 12.74));

  LatLngBounds get mapPosition => _mapPosition;
  set mapPosition(LatLngBounds b) {
    print("set to $b");
    _mapPosition = b;
  }
}
