import 'dart:convert';
import 'package:app/screens/details_screen.dart';
import 'package:app/widgets/details_short.dart';
import 'package:app/widgets/bar_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:http/http.dart' as http;

// ignore_for_file: avoid_print
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  ValueNotifier<String> activity = ValueNotifier("-");
  MapSearchBar? searchBar;
  ActivityMarkerMap? mapWidget;

  @override
  Widget build(BuildContext context) {
    searchBar = MapSearchBar(mapState: this);

    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    mapWidget = ActivityMarkerMap(height: height, width: width, mapState: this);

    return Stack(
      children: [
        mapWidget!,
        searchBar!,
        const BuildContainer(),
      ],
    );
  }
}

class BuildContainer extends StatelessWidget {
  const BuildContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 100),
        height: height / 7,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoxesDetails(
                imageurl:
                    "https://cdn.pixabay.com/photo/2016/02/18/23/27/table-tennis-1208383_960_720.jpg",
                lat: 13.3086758,
                long: 52.5748306,
                titel: "Tischtennis",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const DetailsScreen(locationId: "location-id-1"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoxesDetails(
                imageurl:
                    "https://cdn.pixabay.com/photo/2014/11/29/17/49/playground-550535_960_720.jpg",
                lat: 13.4496164,
                long: 52.5317128,
                titel: "Tischtennis",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const DetailsScreen(locationId: "location-id-2"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: BoxesDetails(
                  imageurl:
                      "https://cdn.pixabay.com/photo/2016/09/05/23/28/blue-1648005_960_720.jpg",
                  lat: 13.4496164,
                  long: 52.5317128,
                  titel: "Tischtennis",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DetailsScreen(locationId: "location-id-3"),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class ActivityMarkerMap extends StatefulWidget {
  const ActivityMarkerMap({
    super.key,
    required this.width,
    required this.height,
    required this.mapState,
  });

  final double width;
  final double height;
  final MapScreenState mapState;

  @override
  State<ActivityMarkerMap> createState() {
    return _ActivityMarkerMapState();
  }
}

class _ActivityMarkerMapState extends State<ActivityMarkerMap> {
  LatLngBounds bounds = LatLngBounds(LatLng(52.37, 12.74), LatLng(53, 13.04));
  List<MyMarker> markers = [];
  final MapController mapController = MapController();

  void onMapEvent(MapEvent event) {
    if (event is! MapEventMoveEnd) return;

    print("move triggered");
    setState(() {
      bounds = mapController.bounds!;
    });
    performSearch();
  }

  Future<void> performSearch() async {
    print(
        '${bounds.south}, ${bounds.west}, ${bounds.east}, ${widget.mapState.activity.value}');
    print("fetch locations started");
    List<MyMarker> markers_ =
        await fetchLocations(bounds, widget.mapState.activity.value);
    setState(() {
      markers = markers_;
      print("state set... with ${markers.length} items");
    });
  }

  @override
  void initState() {
    widget.mapState.activity.addListener(() {
      print("set_activity triggered");
      performSearch();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(bounds: bounds, onMapEvent: onMapEvent),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }
}

var client = http.Client();

class MyMarker extends Marker {
  MyMarker({
    required super.point,
    required super.builder,
    required super.width,
    required super.height,
    required super.anchorPos,
    //  required this.id
  });

  // final String id;
}

MyMarker markerFromJson(Map<String, dynamic> json) {
  var loc = LatLng(
      json["location"]["coordinates"][1], json["location"]["coordinates"][0]);
  String id = json["id"];

  return MyMarker(
      point: loc,
      width: 20,
      height: 20,
      builder: (context) => IconButton(
            icon: const Icon(Icons.location_pin),
            onPressed: () {
              print("marker pressed with id: $id");
              // TODO: open widget and fetch data
            },
          ),
      anchorPos: AnchorPos.align(AnchorAlign.top));
}

List<MyMarker> parseMarkers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<MyMarker>((json) => markerFromJson(json)).toList();
}

Future<List<MyMarker>> fetchLocations(
    LatLngBounds bounds, String activity) async {
  final response = await http.get(
      Uri(
          scheme: "http",
          host: "192.168.188.164",
          port: 8000,
          path: '/locations/bbox',
          queryParameters: {
            "west": bounds.west.toString(),
            "east": bounds.east.toString(),
            "south": bounds.south.toString(),
            "north": bounds.north.toString(),
            if (activity.isNotEmpty) "activities": activity
          }),
      headers: {
        'Access-Control-Allow-Origin': "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      });
  if (response.statusCode == 200) {
    return parseMarkers(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}
