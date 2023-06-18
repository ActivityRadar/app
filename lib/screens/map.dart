import 'dart:convert';

import 'package:app/constants/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:http/http.dart' as http;

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  SearchBar searchBar = SearchBar();
  MapWidget? mapWidget;

  @override
  Widget build(BuildContext context) {
    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    final mapController = MapController();
    mapWidget =
        MapWidget(mapController: mapController, height: height, width: width);
    searchBar._map = mapWidget;
    return Stack(
      children: [
        mapWidget!,
        searchBar,
        BuildContainer(),
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
          children: const <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: BoxesDetails(
                  imageurl:
                      "https://cdn.pixabay.com/photo/2016/02/18/23/27/table-tennis-1208383_960_720.jpg",
                  lat: 13.3086758,
                  long: 52.5748306,
                  titel: "Tischtennis"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: BoxesDetails(
                  imageurl:
                      "https://cdn.pixabay.com/photo/2014/11/29/17/49/playground-550535_960_720.jpg",
                  lat: 13.4496164,
                  long: 52.5317128,
                  titel: "Tischtennis"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: BoxesDetails(
                  imageurl:
                      "https://cdn.pixabay.com/photo/2016/09/05/23/28/blue-1648005_960_720.jpg",
                  lat: 13.4496164,
                  long: 52.5317128,
                  titel: "Tischtennis"),
            ),
          ],
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  MapWidget({
    super.key,
    required this.mapController,
    required this.width,
    required this.height,
  });

  final MapController mapController;
  final double width;
  final double height;
  List<Marker> markers = [];
  dynamic markerLayer = MarkerLayer(markers: []);
  FlutterMap? map;
  String _activity = "table_tennis";

  set activity(String activity) {
    _activity = activity;
    print("set_activity triggered");
    performSearch();
  }

  Future<void> performSearch() async {
    LatLngBounds bounds = mapController.bounds!;
    print('${bounds.south}, ${bounds.west}, ${bounds.east}, $_activity');

    // markerLayer = MarkerLayer(markers: );
    // Future<List<Marker>> futureMarkers = fetchLocations(bounds, _activity);
    List<Marker> markers_ = await fetchLocations(bounds, _activity);
    print("fetch locations started");

    // map!.children[1] = FutureBuilder<List<Marker>>(
    //     // markerLayer = FutureBuilder<List<Marker>>(
    //     future: futureMarkers,
    //     builder: (context, snapshot) {
    //       print("Builder called to check in");
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) print(snapshot.error);
    //         if (snapshot.hasData) {
    //           print(snapshot.data!.length);
    //           return MarkerLayer(markers: snapshot.data!);
    //         }
    //       }
    //       return const Center(child: CircularProgressIndicator());
    //     });

    map!.children[1] = MarkerLayer(markers: markers_);
    // map!.mapController!.move(mapController.center, mapController.zoom);
    // map!.createState();
  }

  void onZoom(MapEvent event) {
    if (event is! MapEventMoveEnd) return;
    print("move triggered");
    performSearch();
  }

  @override
  Widget build(BuildContext context) {
    map = FlutterMap(
      mapController: mapController,
      options: MapOptions(
          center: LatLng(51.5167, 9.9167), zoom: 10.2, onMapEvent: onZoom),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        markerLayer,
      ],
    );
    return map!;
  }
}

// class Map extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }

var client = http.Client();

Marker markerFromJson(Map<String, dynamic> json) {
  var loc = LatLng(
      json["location"]["coordinates"][1], json["location"]["coordinates"][0]);

  return Marker(
      point: loc,
      width: 1,
      height: 1,
      builder: (context) => const Icon(Icons.location_pin),
      anchorPos: AnchorPos.align(AnchorAlign.bottom));
}

List<Marker> parseMarkers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Marker>((json) => markerFromJson(json)).toList();
}

Future<List<Marker>> fetchLocations(
    LatLngBounds bounds, String activity) async {
  // var request =
  //     http.Request("GET", Uri(path: "http://localhost:8000/locations/bbox"));
  //
  // final response =
  //     await request.send(); // http.get('http://localhost:8000/locations/bbox');

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
            "activities": activity
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
  SearchBar({
    super.key,
  });

  MapWidget? _map;

  void setActivity(String activity) {
    _map!.activity = activity;
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

class BoxesDetails extends StatelessWidget {
  const BoxesDetails({
    super.key,
    required this.imageurl,
    required this.lat,
    required this.long,
    required this.titel,
  });

  final String imageurl;
  final double lat;
  final double long;
  final String titel;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return GestureDetector(
      onTap: () {},
      child: new FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 180,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: new Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageurl),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DetailContainer(titel: titel),
              )
            ],
          ),
        ),
      ),
    );
  }

  myDetailsContainer({required id}) {}
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    super.key,
    required this.titel,
  });

  final String titel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            titel,
            style: const TextStyle(
                color: DesignColors.naviColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star_half_sharp,
              color: Colors.amber,
              size: 15.0,
            ),
            Text(
              "(243)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )
          ],
        ),
        const SizedBox(height: 5.0),
        const Text(
          "KM entfernt",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
