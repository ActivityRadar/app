import 'dart:async';
import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class GpsLocationNotifier extends ChangeNotifier {
  LocationData? _location;
  DateTime _lastUpdate = DateTime(1900);

  late Timer _timer;
  final _outDatedInfoDuration = const Duration(seconds: 10);
  bool _moveToLocation = false;
  bool enabled = false;

  GpsLocationNotifier() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      enabled = await Location().serviceEnabled();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void setLocation({required LocationData location, bool move = false}) {
    _location = location;
    _lastUpdate = DateTime.now();
    _moveToLocation = move;
    enabled = true;
    notifyListeners();
  }

  LatLng? get coordinates {
    if (_location == null || _location!.latitude == null) {
      return null;
    }

    return LatLng(_location!.latitude!, _location!.longitude!);
  }

  bool get recent {
    return DateTime.now().difference(_lastUpdate) < _outDatedInfoDuration &&
        enabled;
  }

  bool get shouldMove {
    return _moveToLocation;
  }

  set shouldMove(bool move) {
    _moveToLocation = move;
  }
}

class GpsButton extends StatefulWidget {
  const GpsButton({super.key, required this.gpsNotifier});

  final GpsLocationNotifier gpsNotifier;

  @override
  State<GpsButton> createState() => _GpsButtonState();
}

class _GpsButtonState extends State<GpsButton> {
  bool active = false;
  StreamSubscription<LocationData>? locationSubscription;

  void onServiceStatusChange() {
    // only deactivate the button state when service is disabled
    // dont activate the button if service is enabled
    if (!widget.gpsNotifier.enabled) {
      locationSubscription?.cancel();
      setState(() {
        active = false;
      });
    }
  }

  @override
  void initState() {
    widget.gpsNotifier.addListener(onServiceStatusChange);

    super.initState();
  }

  @override
  void dispose() {
    widget.gpsNotifier.removeListener(onServiceStatusChange);
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final pos = await Location().getLocation();
          print(pos);
          if (pos.latitude != null) {
            widget.gpsNotifier.setLocation(location: pos, move: true);
          }

          // initiate location listener
          if (!active) {
            print("listener started");
            locationSubscription = Location()
                .onLocationChanged
                .listen((LocationData currentLocation) {
              print("listened to position change");
              if (currentLocation.latitude != null) {
                widget.gpsNotifier
                    .setLocation(location: currentLocation, move: false);
              }
            });
          }

          setState(() {
            active = true;
          });
        },
        icon: Icon(active ? AppIcons.gpsFixed : AppIcons.gpsOff),
        color: active ? Colors.blue : Colors.black);
  }
}
