import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app/constants/design.dart';

class MeetMap extends StatefulWidget {
  const MeetMap({
    super.key,
  });

  @override
  State<MeetMap> createState() {
    return _MeetMapState();
  }
}

class _MeetMapState extends State<MeetMap> {
  LatLngBounds bounds =
      LatLngBounds(const LatLng(52.37, 12.74), const LatLng(50, 13.04));
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    const LatLng center = LatLng(52.520008, 13.404954);
    //TODO Circlemarker or Circle
    final circleMarkers = <CircleMarker>[
      CircleMarker(
        point: center,
        color: DesignColors.blueColor.withOpacity(0.5),
        borderStrokeWidth: 1,
        borderColor: Colors.black12,
        useRadiusInMeter: true,
        radius: 200, // 2000 meters | 2 km
      ),
    ];
    return Stack(children: [
      IgnorePointer(
        child: FlutterMap(
          options: MapOptions(center: center, zoom: 10),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            CircleLayer(circles: circleMarkers),
          ],
        ),
      )
    ]);
  }
}
