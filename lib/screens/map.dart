import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    final mapController = MapController();
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(51.5167, 9.9167),
            zoom: 5.2,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(52.520008, 13.404954),
                  width: width / 1,
                  height: height / 1,
                  builder: (context) => const Icon(Icons.sports_tennis_sharp),
                ),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
          child: Column(
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.filter_alt),
                    suffixIcon: Icon(Icons.search),
                    hintStyle: TextStyle(fontSize: 15.0, color: Colors.black12),
                    hintText:
                        "Search basketball, volleyball, table tennis ... ",
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
