import 'package:app/screens/addlocation.dart';
import 'package:app/widgets/custom/button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default

// ignore_for_file: avoid_print
class LocationPickerMap extends StatefulWidget {
  const LocationPickerMap({Key? key}) : super(key: key);

  @override
  LocationPickerMapState createState() {
    return LocationPickerMapState();
  }
}

class LocationPickerMapState extends State<LocationPickerMap> {
  ValueNotifier<String> activity = ValueNotifier("-");

  LocationMarkerMap? mapWidget;

  @override
  Widget build(BuildContext context) {
    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    mapWidget = LocationMarkerMap(height: height, width: width, mapState: this);

    return Stack(
      children: [
        mapWidget!,
        const PinIcon(),
      ],
    );
  }
}

class PinIcon extends StatelessWidget {
  const PinIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.bottomLeft,
      child: Center(
        heightFactor: 110,
        child: Icon(
          Icons.push_pin,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}

class LocationMarkerMap extends StatefulWidget {
  const LocationMarkerMap({
    super.key,
    required this.width,
    required this.height,
    required this.mapState,
  });

  final double width;
  final double height;
  final LocationPickerMapState mapState;

  @override
  State<LocationMarkerMap> createState() {
    return _LocationMarkerMapState();
  }
}

class _LocationMarkerMapState extends State<LocationMarkerMap> {
  LatLngBounds bounds = LatLngBounds(LatLng(52.37, 12.74), LatLng(53, 13.04));
  final MapController mapController = MapController();

  void onMapEvent(MapEvent event) {
    if (event is! MapEventMoveEnd) return;
    print("move triggered");
    setState(() {
      mapController.center;
      print("'mapController.center'");
      print(mapController.center);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: mapController,
        options: MapOptions(bounds: bounds, onMapEvent: onMapEvent),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      ),
      Column(children: <Widget>[
        Expanded(
            child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddLocation(),
                ),
              );
            },
            text: "Bottom Button!",
          ),
        ))
      ])
    ]);
  }
}
