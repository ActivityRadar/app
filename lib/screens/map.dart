import 'dart:math';
import 'package:app/app_state.dart';
import 'package:app/constants/design.dart';
import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/activity_type.dart';
import 'package:app/provider/generated/locations_provider.dart';
import 'package:app/widgets/loaction_icon.dart';
import 'package:app/widgets/short_info_slider.dart';
import 'package:app/widgets/bar_search.dart';
import 'package:app/widgets/gps.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

final flutterMapTileLayer = TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    subdomains: const ['a', 'b', 'c'],
    tileProvider: FMTC.instance('mapStore').getTileProvider());

// ignore_for_file: avoid_print
class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  MapScreenState createState() {
    return MapScreenState();
  }
}

enum FocusChangeReason { markerTap, slider, unfocus, back }

class FocusedLocationNotifier extends ChangeNotifier {
  LocationShortApi? _info;
  FocusChangeReason _changedBy = FocusChangeReason.unfocus;

  LocationShortApi? get info => _info;
  FocusChangeReason get changedBy => _changedBy;

  void setFocused(
      {LocationShortApi? info,
      FocusChangeReason changedBy = FocusChangeReason.unfocus}) {
    _info = info;
    _changedBy = changedBy;
    notifyListeners();
  }
}

class MapScreenState extends State<MapScreen> {
  ValueNotifier<List<String>> activities = ValueNotifier([""]);
  late MapSearchBar searchBar;
  late ActivityMarkerMap mapWidget;
  FocusedLocationNotifier focusedLocationInfo = FocusedLocationNotifier();
  List<LocationDetailedApi>? sliderInfos;
  ShortInfoSlider? infoSlider;
  ValueNotifier<int> focusedInfosIndex = ValueNotifier(0);
  GpsLocationNotifier currentPosition = GpsLocationNotifier();
  late GpsButton gpsButton;

  void buildSlider(LocationShortApi info) async {
    final coordinates = toLatLng(info.location);
    sliderInfos = await LocationsProvider.getLocationsAround(
        long: coordinates.longitude,
        lat: coordinates.latitude,
        activities: ActivityManager.instance.getBackendTypes(activities.value));

    setState(() {
      print("buildSlider");
      infoSlider = ShortInfoSlider(
          key: UniqueKey(),
          infos: sliderInfos!,
          indexNotifier: focusedInfosIndex,
          locationNotifier: focusedLocationInfo);
    });
  }

  void onFocusChanged() {
    final info = focusedLocationInfo.info;

    if (info == null) {
      return;
    }

    if (infoSlider != null) {
      final idx = sliderInfos!.indexWhere((sInfo) => sInfo.id == info.id);
      if (idx == -1) {
        buildSlider(info);
      } else {
        focusedInfosIndex.value = idx;
      }
    } else {
      buildSlider(info);
    }
  }

  void onCurrentPositionChange() {
    if (currentPosition.coordinates != null) {
      final state = Provider.of<AppState>(context, listen: false);
      state.userPosition = currentPosition.coordinates!;
      state.userPositionTime = currentPosition.lastUpdate!;
    }
  }

  @override
  void initState() {
    super.initState();
    gpsButton = GpsButton(gpsNotifier: currentPosition);
    searchBar = MapSearchBar(mapState: this);
    mapWidget = ActivityMarkerMap(
        focusedLocation: focusedLocationInfo,
        activities: activities,
        currentPosition: currentPosition);

    focusedLocationInfo.addListener(onFocusChanged);
    currentPosition.addListener(onCurrentPositionChange);
  }

  @override
  void dispose() {
    focusedLocationInfo.removeListener(onFocusChanged);
    currentPosition.removeListener(onCurrentPositionChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    final state = Provider.of<AppState>(context, listen: false);
    currentPosition.setFromStorage(state.userPosition, state.userPositionTime);

    return WillPopScope(
        onWillPop: () async {
          if (focusedLocationInfo.changedBy != FocusChangeReason.back) {
            focusedLocationInfo.setFocused(
                info: null, changedBy: FocusChangeReason.back);
            setState(() {
              infoSlider = null;
            });
            return false;
          }
          return true;
        },
        child: Stack(
          children: [
            mapWidget,
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 25, horizontal: 16.0),
                child: Column(
                  children: [
                    searchBar,
                    Align(alignment: Alignment.centerRight, child: gpsButton)
                  ],
                )),
            if (infoSlider != null)
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 100),
                      child: infoSlider!))
          ],
        ));
  }
}

class ActivityMarkerMap extends StatefulWidget {
  const ActivityMarkerMap({
    super.key,
    required this.focusedLocation,
    required this.activities,
    required this.currentPosition,
    this.onNewMarkerTap,
    this.onNewMarkerCreate,
  });

  final FocusedLocationNotifier focusedLocation;
  final ValueNotifier<List<String>> activities;
  final GpsLocationNotifier currentPosition;
  final void Function(LatLng)? onNewMarkerTap;
  final void Function(LatLng)? onNewMarkerCreate;

  @override
  State<ActivityMarkerMap> createState() {
    return _ActivityMarkerMapState();
  }
}

class _ActivityMarkerMapState extends State<ActivityMarkerMap>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late LatLngBounds bounds;
  List<LocationMarker> markers = [];
  late final AnimatedMapController mapController =
      AnimatedMapController(vsync: this);
  String? focusedLocationId;
  CircleLayer? currentPositionLayer;
  Marker? newMarker;

  Marker buildNewMarker(LatLng position) {
    return Marker(
        point: position,
        width: 50,
        height: 50 * 0.9,
        anchorPos:
            AnchorPos.align(AnchorAlign.top), // top for "above the position"
        builder: (context) {
          return GestureDetector(
              onTap: () {
                widget.onNewMarkerTap?.call(position);
              },
              child:
                  const Icon(Icons.location_pin, color: Colors.blue, size: 50));
        });
  }

  @override
  get wantKeepAlive => true;

  void onMapEvent(MapEvent event, BuildContext context) {
    final s = Provider.of<AppState>(context, listen: false);

    // every event has these
    s.zoom = event.zoom;
    s.center = event.center;

    if (event is MapEventTap) {
      widget.focusedLocation
          .setFocused(info: null, changedBy: FocusChangeReason.unfocus);

      setState(() {
        newMarker = buildNewMarker(event.tapPosition);
      });
      widget.onNewMarkerCreate?.call(newMarker!.point);
      return;
    }
    if (event is! MapEventMoveEnd) return;

    print("move triggered");

    s.mapPosition = mapController.mapController.bounds!;

    setState(() {
      bounds = mapController.mapController.bounds!;
    });
    performSearch();
  }

  void onMarkerClick(LocationShortApi loc) {
    widget.focusedLocation
        .setFocused(info: loc, changedBy: FocusChangeReason.markerTap);
  }

  void onFocusChanged(String? oldFocused, LocationShortApi? loc,
      {bool move = false}) {
    focusedLocationId = loc?.id;
    if (oldFocused != null) {
      final idx = markers.indexWhere((m) => m.location.id == oldFocused);

      // only redraw if old focused marker is in view (and thus in the array)
      if (idx != -1) {
        final unfocusedMarker = createMarker(markers[idx].location);
        markers.removeAt(idx);
        markers.add(unfocusedMarker);
      }
    }

    if (loc != null) {
      markers.removeWhere((m) => m.location.id == loc.id);
      markers.add(createMarker(loc));

      if (move) {
        mapController.centerOnPoint(toLatLng(loc.location));
      }
    }

    if (newMarker != null) {
      print("newMarker reset");
      newMarker = null;
    }
  }

  void onMarkerDoubleTap() {
    mapController.animatedZoomIn();
  }

  LocationMarker createMarker(LocationShortApi loc) {
    return LocationMarker.fromLocation(loc,
        onPressed: onMarkerClick,
        onDoubleTap: onMarkerDoubleTap,
        focused: (focusedLocationId != null && loc.id == focusedLocationId));
  }

  Future<void> performSearch() async {
    print(
        '${bounds.south}, ${bounds.west}, ${bounds.east}, ${widget.activities.value}');
    print("fetch locations started");

    List<LocationShortApi> locations =
        await LocationsProvider.getLocationsByBbox(
            north: bounds.north,
            south: bounds.south,
            west: bounds.west,
            east: bounds.east,
            activities: ActivityManager.instance
                .getBackendTypes(widget.activities.value));
    print(locations.length);

    List<LocationMarker> markers_ =
        locations.map((loc) => createMarker(loc)).toList();

    setState(() {
      markers = markers_;
      print("state set... with ${markers.length} items");
    });
  }

  void onGpsUpdate() {
    final pos = widget.currentPosition.coordinates;
    final List<CircleMarker> circles = [];
    if (pos != null) {
      final color =
          widget.currentPosition.recent ? DesignColors.blue : Colors.grey;
      circles.add(CircleMarker(
          radius: 8,
          point: pos,
          color: color,
          borderStrokeWidth: 5.0,
          borderColor: Colors.black45));

      if (widget.currentPosition.shouldMove) {
        mapController.animateTo(dest: pos, zoom: 14);
        widget.currentPosition.shouldMove = false;
      }
    }

    setState(() {
      currentPositionLayer = CircleLayer(
        circles: circles,
      );
    });
  }

  void focusChangeCallback() {
    if (widget.focusedLocation.changedBy == FocusChangeReason.back &&
        newMarker != null) {
      setState(() {
        newMarker = null;
      });
      return;
    }

    final oldFocused = focusedLocationId;
    final move = widget.focusedLocation.changedBy == FocusChangeReason.slider;
    setState(() {
      onFocusChanged(oldFocused, widget.focusedLocation.info, move: move);
    });
  }

  @override
  void initState() {
    super.initState();

    widget.activities.addListener(performSearch);
    widget.focusedLocation.addListener(focusChangeCallback);
    widget.currentPosition.addListener(onGpsUpdate);
  }

  @override
  void dispose() {
    widget.activities.removeListener(performSearch);
    widget.focusedLocation.removeListener(focusChangeCallback);
    widget.currentPosition.removeListener(onGpsUpdate);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    const maxBubbleSize = 40;
    const minBubbleSize = 15;
    const exponent = 1.3;
    final nAll = markers.length;
    double bubbleSizeByNumber(n) =>
        (n / nAll) * (maxBubbleSize - minBubbleSize) + minBubbleSize;
    // TODO: find a more robust scaling system
    double bubbleScale(s) => pow(s, exponent).toDouble();

    bounds = Provider.of<AppState>(context).mapPosition;
    onGpsUpdate();

    return FlutterMap(
      mapController: mapController.mapController,
      options: MapOptions(
          bounds: bounds,
          onMapEvent: (event) => onMapEvent(event, context),
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate),
      children: [
        flutterMapTileLayer,
        if (currentPositionLayer != null) currentPositionLayer!,
        if (newMarker != null) MarkerLayer(markers: [newMarker!]),
        MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
          maxClusterRadius: bubbleScale(maxBubbleSize).ceil(),
          disableClusteringAtZoom: 14,
          computeSize: (ms) {
            // ATTENTION: This function called for every cluster every time the
            // cluster is rerendered. So, very often. Dont do too much computation here.
            final s = bubbleScale(bubbleSizeByNumber(ms.length));
            // print("$l, $nAll, $r, $s");

            return Size(s, s);
          },
          markers: List.from(markers),
          builder: (context, ms) {
            return Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: DesignColors.blue),
              child: Center(
                child: MapText(
                  text: ms.length.toString(),
                ), // TODO: one marker might actually indicate multiple instances
                // like 2 table_tennis tables. So this will have to be adjusted.
              ),
            );
          },
        )),
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

  factory LocationMarker.fromLocation(LocationShortApi location,
      {Function(LocationShortApi)? onPressed,
      Function()? onDoubleTap,
      bool focused = false}) {
    final size = focused ? 45.0 : 40.0;
    final color = focused ? DesignColors.red : Colors.black;

    if (focused) print("is focused");

    return LocationMarker(location,
        point: toLatLng(location.location),
        width: size,
        // adjust for weird padding-like issue
        // this might be because the Icon itself has a small padding
        height: size * 9 / 10,
        anchorPos:
            AnchorPos.align(AnchorAlign.top), // top for "above the position"
        builder: (context) => GestureDetector(
              onTap: () => onPressed == null ? {} : onPressed(location),
              onDoubleTap: onDoubleTap,
              child: LocationIcon(color: color, size: size),
            ));
  }
}
