import 'dart:math';

import 'package:app/constants/design.dart';
import 'package:app/screens/map.dart';
import 'package:app/util/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';

class RadiusSelectionMap extends StatelessWidget {
  const RadiusSelectionMap({
    super.key,
    required this.radius,
    required this.center,
  });

  final ValueNotifier<double> radius;
  final LatLng center;

  @override
  Widget build(BuildContext context) {
    return MultipleRadiusesSelectionMap(
        notifiers: [radius], colors: const [DesignColors.blue], center: center);
  }
}

class MultiValueNotifier<T> extends ValueNotifier<List<T>> {
  MultiValueNotifier(List<T> value) : super(value);

  void setValue(int index, T val) {
    value[index] = val;
    notifyListeners();
  }
}

class MultipleRadiusesSelectionMap extends StatefulWidget {
  const MultipleRadiusesSelectionMap(
      {super.key,
      required this.notifiers,
      required this.colors,
      required this.center});

  final List<ValueNotifier<double>> notifiers;
  final List<Color> colors;
  final LatLng center;

  @override
  State<MultipleRadiusesSelectionMap> createState() =>
      _MultipleRadiusesSelectionMapState();
}

class _MultipleRadiusesSelectionMapState
    extends State<MultipleRadiusesSelectionMap> with TickerProviderStateMixin {
  late final AnimatedMapController animatedMapController =
      AnimatedMapController(
          vsync: this,
          duration: const Duration(milliseconds: 20),
          curve: Curves.linear);

  late final MultiValueNotifier<double> notifiers;

  @override
  void initState() {
    super.initState();

    notifiers =
        MultiValueNotifier(widget.notifiers.map((n) => n.value).toList());
    for (var entry in widget.notifiers.asMap().entries) {
      entry.value.addListener(() => updateZoom(entry.key));
    }
  }

  @override
  void dispose() {
    for (var entry in widget.notifiers.asMap().entries) {
      entry.value.addListener(() => updateZoom(entry.key));
    }

    super.dispose();
  }

  void updateZoom(int index) {
    notifiers.setValue(index, widget.notifiers[index].value);
    animatedMapController
        .animatedZoomTo(getZoomLevel(getCircleRadius(getMaxRadius())));
  }

  double getMaxRadius() {
    return widget.notifiers.map((notifier) => notifier.value).reduce(max);
  }

  double getCircleRadius(double radius) {
    return radius * 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FlutterMap(
        mapController: animatedMapController.mapController,
        options: MapOptions(
            center: widget.center,
            zoom: getZoomLevel(getCircleRadius(getMaxRadius()))),
        children: [
          createCachedTileLayer(),
          ValueListenableBuilder(
              valueListenable: notifiers,
              builder: (context, value, child) {
                return CircleLayer(
                  circles: notifiers.value
                      .asMap()
                      .entries
                      .map((entry) => CircleMarker(
                            point: widget.center,
                            color: widget.colors[entry.key].withOpacity(0.5),
                            borderStrokeWidth: 1,
                            borderColor: Colors.black12,
                            useRadiusInMeter: true,
                            radius: getCircleRadius(
                                entry.value), // 2000 meters | 2 km
                          ))
                      .toList(),
                );
              })
        ],
      ),
    ]);
  }
}
