import 'package:app/screens/map.dart';
import 'package:app/util/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app/constants/design.dart';

class MeetMap extends StatefulWidget {
  const MeetMap({
    super.key,
    required this.center,
    this.radius = 0.3,
    this.circleScale = 150,
  });

  final LatLng center;
  final double radius; // in km
  final double circleScale;

  @override
  State<MeetMap> createState() {
    return _MeetMapState();
  }
}

class _MeetMapState extends State<MeetMap> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    //TODO Circlemarker or Circle
    final circleMarkers = <CircleMarker>[
      CircleMarker(
        point: widget.center,
        color: DesignColors.blue.withOpacity(0.5),
        borderStrokeWidth: 1,
        borderColor: Colors.black12,
        useRadiusInMeter: true,
        radius: widget.radius * 1000, // radius in meters
      ),
    ];
    return Stack(children: [
      IgnorePointer(
        child: FlutterMap(
          // TODO: dynamic zoom (depending on radius)
          options: MapOptions(
              center: widget.center,
              zoom: getZoomLevel(widget.radius * 1000,
                  scale: widget.circleScale)),
          children: [
            createCachedTileLayer(),
            CircleLayer(circles: circleMarkers),
          ],
        ),
      )
    ]);
  }
}
