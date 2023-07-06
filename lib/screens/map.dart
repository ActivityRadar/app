import 'dart:convert';
import 'package:app/screens/details_screen.dart';
import 'package:app/widgets/details_short.dart';
import 'package:app/constants/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  ValueNotifier<String> activity = ValueNotifier("-");
  SearchBar? searchBar;
  ActivityMarkerMap? mapWidget;

  @override
  Widget build(BuildContext context) {
    searchBar = SearchBar(mapState: this);
    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    final mapController = MapController();
    mapWidget = ActivityMarkerMap(
        mapController: mapController,
        height: height,
        width: width,
        mapState: this);
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
  const BuildContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 80),
        height: 130.0,
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
                      builder: (context) => DetailsScreen(),
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
                      builder: (context) => DetailsScreen(),
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
                        builder: (context) => DetailsScreen(),
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
  ActivityMarkerMap({
    super.key,
    required this.mapController,
    required this.width,
    required this.height,
    required this.mapState,
  });

  final MapController mapController;
  final double width;
  final double height;
  MapScreenState mapState;

  @override
  _ActivityMarkerMapState createState() {
    return _ActivityMarkerMapState();
  }
}

class _ActivityMarkerMapState extends State<ActivityMarkerMap> {
  LatLngBounds bounds = LatLngBounds(LatLng(52.37, 12.74), LatLng(53, 13.04));
  List<Marker> markers = [];

  void onMapEvent(MapEvent event) {
    if (event is! MapEventMoveEnd) return;
    // ignore_for_file: avoid_print
    print("move triggered");
    performSearch();
  }

  Future<void> performSearch() async {
    bounds = widget.mapController.bounds!;
    print(
        '${bounds.south}, ${bounds.west}, ${bounds.east}, ${widget.mapState.activity.value}');
    print("fetch locations started");
    List<Marker> markers_ =
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
      mapController: widget.mapController,
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

Marker markerFromJson(Map<String, dynamic> json) {
  var loc = LatLng(
      json["location"]["coordinates"][1], json["location"]["coordinates"][0]);

  return Marker(
      point: loc,
      width: 20,
      height: 20,
      builder: (context) => const Icon(Icons.location_pin),
      anchorPos: AnchorPos.align(AnchorAlign.top));
}

List<Marker> parseMarkers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Marker>((json) => markerFromJson(json)).toList();
}

Future<List<Marker>> fetchLocations(
    LatLngBounds bounds, String activity) async {
  final response = await http.get(
      Uri(
          scheme: "http",
          host: "localhost",
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

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.mapState});

  final MapScreenState mapState;

  void setActivity(String activity) {
    mapState.activity.value = activity;
    print('set activity to: $activity');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
      child: Column(
        children: [
          Card(
              child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.filter_alt),
              suffixIcon: Icon(Icons.search),
              hintStyle: TextStyle(fontSize: 15.0, color: Colors.black12),
              hintText: "Search basketball, volleyball, table tennis ... ",
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: setActivity,
          ))
        ],
      ),
    );
  }
}
