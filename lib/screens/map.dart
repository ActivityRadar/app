import 'package:app/constants/contants.dart';
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
        MapWidget(
          mapController: mapController,
          height: height,
          width: width,
        ),
        SearchBar(),
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
  const MapWidget({
    super.key,
    required this.mapController,
    required this.width,
    required this.height,
  });

  final MapController mapController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
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
        MarkerLayer(markers: testmarker),
      ],
    );
  }
}

Marker test = Marker(
  point: LatLng(52.5748306, 13.3086758),
  width: 1,
  height: 1,
  builder: (context) => const Icon(Icons.sports_tennis_sharp),
);
Marker test2 = Marker(
  point: LatLng(52.5317128, 13.4496164),
  width: 1,
  height: 1,
  builder: (context) => const Icon(Icons.sports_tennis_sharp),
);
var testmarker = [test, test2];

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 34.0, horizontal: 16.0),
      child: Column(
        children: [
          Card(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.filter_alt),
                suffixIcon: Icon(Icons.search),
                hintStyle: TextStyle(fontSize: 15.0, color: Colors.black12),
                hintText: "Search basketball, volleyball, table tennis ... ",
              ),
            ),
          )
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
