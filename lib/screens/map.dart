import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/details_screen.dart';
import 'package:app/widgets/details_short.dart';
import 'package:app/widgets/bar_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default

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
  late MapSearchBar searchBar;
  late ActivityMarkerMap mapWidget;
  bool infoSliderVisible = false;
  ShortInfoSlider? infoSlider;

  void onMarkerClick(LocationShortApi info) {
    setState(() {
      print("info slider build: ${info.id}");
      infoSlider = ShortInfoSlider(info: info);
    });
    if (infoSliderVisible) {
      // TODO: just change the boxes
    } else {
      // TODO: let the slider pop up
    }
  }

  @override
  void initState() {
    super.initState();
    searchBar = MapSearchBar(mapState: this);
  }

  @override
  Widget build(BuildContext context) {
    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    mapWidget = ActivityMarkerMap(height: height, width: width, mapState: this);

    return Stack(
      children: [
        mapWidget,
        searchBar,
        if (infoSlider != null) infoSlider!,
      ],
    );
  }
}

class ShortInfoBox extends StatelessWidget {
  const ShortInfoBox({super.key, required this.info});

  final LocationDetailedApi info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BoxesDetails(
            imageUrl: info.photos.isEmpty ? null : info.photos[0].url,
            titel: info.activityType,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(locationInfo: info),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class InfoBoxPlaceholder extends StatelessWidget {
  const InfoBoxPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BoxesDetails(
            imageUrl: null,
            titel: "BLA",
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class ShortInfoSlider extends StatefulWidget {
  const ShortInfoSlider({super.key, required this.info});

  final LocationShortApi info;

  @override
  State<ShortInfoSlider> createState() => _ShortInfoSliderState();
}

class _ShortInfoSliderState extends State<ShortInfoSlider> {
  late Future<List<LocationDetailedApi>> infos;

  @override
  void initState() {
    super.initState();
    infos = LocationService().getAroundCenter(widget.info.location);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 100),
        height: height / 7,
        child: FutureBuilder(
          future: infos,
          builder: (BuildContext context,
              AsyncSnapshot<List<LocationDetailedApi>> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!
                      .map((info) => ShortInfoBox(info: info))
                      .toList());
            } else if (snapshot.hasError) {
              print(snapshot.error);
            }
            return ListView(scrollDirection: Axis.horizontal, children: const [
              InfoBoxPlaceholder(),
              InfoBoxPlaceholder(),
              InfoBoxPlaceholder()
            ]);
          },
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

    List<LocationShortApi> locations = await LocationService().getInBoundingBox(
        toLongLat(bounds.southWest),
        toLongLat(bounds.northEast),
        widget.mapState.activity.value);
    print(locations.length);

    List<MyMarker> markers_ = locations
        .map((loc) => MyMarker.fromLocation(loc, widget.mapState.onMarkerClick))
        .toList();

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
      options: MapOptions(
          bounds: bounds,
          onMapEvent: onMapEvent,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate),
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

class MyMarker extends Marker {
  MyMarker(
    this.location, {
    required super.point,
    required super.builder,
    required super.width,
    required super.height,
    required super.anchorPos,
  });

  final LocationShortApi location;

  factory MyMarker.fromLocation(LocationShortApi location, Function onPressed) {
    return MyMarker(location,
        point: toLatLng(location.location),
        width: 20,
        height: 20,
        builder: (context) => IconButton(
              icon: const Icon(Icons.location_pin),
              onPressed: () {
                onPressed(location);
              },
            ),
        anchorPos: AnchorPos.align(AnchorAlign.top));
  }
}
