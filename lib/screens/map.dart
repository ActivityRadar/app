import 'dart:math';

import 'package:app/app_state.dart';
import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/details_screen.dart';
import 'package:app/widgets/short_info_box.dart';
import 'package:app/widgets/bar_search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:provider/provider.dart';

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

class ShortInfoSlider extends StatefulWidget {
  const ShortInfoSlider({super.key, required this.info});

  final LocationShortApi info;

  @override
  State<ShortInfoSlider> createState() => _ShortInfoSliderState();
}

class _ShortInfoSliderState extends State<ShortInfoSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
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
    final verticalSpace = height / 6;
    final horizontalSpace = size.width;
    const viewportFraction = 0.8;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 100),
        height: verticalSpace,
        child: FutureBuilder(
          future: infos,
          builder: (BuildContext context,
              AsyncSnapshot<List<LocationDetailedApi>> snapshot) {
            late List<Widget> boxes;
            if (snapshot.hasData) {
              boxes = snapshot.data!
                  .map((info) => ShortInfoBox(
                        info: info,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(locationInfo: info),
                            ),
                          );
                        },
                      ))
                  .toList();
            } else {
              if (snapshot.hasError) print(snapshot.error);
              boxes = [
                for (int i = 0; i < 5; i++)
                  ShortInfoBox(
                    info: null,
                    onPressed: () {},
                  )
              ];
            }
            return CarouselSlider(
                items: boxes
                    .map((b) => SizedBox(
                          height: verticalSpace,
                          width: horizontalSpace * 0.9,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: b),
                        ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  // ratio between width and height
                  aspectRatio:
                      horizontalSpace / verticalSpace * 1 / viewportFraction,
                  // how much space does the focused box take
                  viewportFraction: viewportFraction,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: false,
                  // enlargeCenterPage: true,
                  // enlargeFactor: 0.3,
                  onPageChanged: (position, reason) {
                    setState(() {
                      print("state set!");
                      _current = position;
                    });
                  },
                ));
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
  late LatLngBounds bounds;
  List<LocationMarker> markers = [];
  final MapController mapController = MapController();

  void onMapEvent(MapEvent event, BuildContext context) {
    final s = Provider.of<AppState>(context, listen: false);

    // every event has these
    s.zoom = event.zoom;
    s.center = event.center;

    if (event is! MapEventMoveEnd) return;

    print("move triggered");

    s.mapPosition = mapController.bounds!;

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

    List<LocationMarker> markers_ = locations
        .map((loc) =>
            LocationMarker.fromLocation(loc, widget.mapState.onMarkerClick))
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
    const maxBubbleSize = 40;
    const minBubbleSize = 15;
    const exponent = 1.3;
    final nAll = markers.length;
    double bubbleSizeByNumber(n) =>
        (n / nAll) * (maxBubbleSize - minBubbleSize) + minBubbleSize;
    // TODO: find a more robust scaling system
    double bubbleScale(s) => pow(s, exponent).toDouble();

    bounds = Provider.of<AppState>(context).mapPosition;

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
          bounds: bounds,
          onMapEvent: (event) => onMapEvent(event, context),
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
          maxClusterRadius: bubbleScale(maxBubbleSize).ceil(),
          computeSize: (ms) {
            // ATTENTION: This function called for every cluster every time the
            // cluster is rerendered. So, very often. Dont do too much computation here.
            final s = bubbleScale(bubbleSizeByNumber(ms.length));
            // print("$l, $nAll, $r, $s");

            return Size(s, s);
          },
          markers: markers,
          builder: (context, ms) {
            return Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: Center(
                child: Text(
                  // TODO: one marker might actually indicate multiple instances
                  // like 2 table_tennis tables. So this will have to be adjusted.
                  ms.length.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}

class LocationMarker extends Marker {
  LocationMarker(
    this.location, {
    required super.point,
    required super.builder,
    super.width,
    super.height,
    super.anchorPos,
  });

  final LocationShortApi location;

  factory LocationMarker.fromLocation(
      LocationShortApi location, Function onPressed) {
    const size = 40.0;
    final m = LocationMarker(location,
        point: toLatLng(location.location),
        width: size,
        // adjust for weird padding-like issue
        // this might be because the Icon itself has a small padding
        height: size * 9 / 10,
        anchorPos:
            AnchorPos.align(AnchorAlign.top), // top for "above the position"
        builder: (context) => GestureDetector(
            onTap: () => onPressed(location),
            child: const Icon(Icons.location_on, size: size)));

    print(m.width);
    return m;
  }
}
