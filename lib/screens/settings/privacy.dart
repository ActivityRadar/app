import 'package:app/screens/map.dart';
import 'package:app/util/map.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:app/constants/design.dart';

class PrivacySettingPage extends StatefulWidget {
  const PrivacySettingPage({super.key});

  @override
  State<PrivacySettingPage> createState() => _PrivacySettingPageState();
}

class _PrivacySettingPageState extends State<PrivacySettingPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;

    return Scaffold(
        body: BackgroundSVG(
      children: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: DesignColors.transparent,
            title: const CustomText(text: "Privacy"),
            centerTitle: true,
            leading: ButtonBack(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
                    child: LittleText(
                      text: "Profil",
                      width: width,
                    ),
                  ),
                  CustomCard(
                    child: Column(
                      children: [
                        ListTile(
                          title: const CustomText(text: 'öffentliches Profil'),
                          trailing: Switch(
                            value: isExpanded,
                            onChanged: (bool value) {
                              setState(() {
                                isExpanded = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
                    child: LittleText(
                      text: "Angebot",
                      width: width,
                    ),
                  ),
                  const CustomCard(
                    child: Column(
                      children: [
                        ExpandableTile(),
                      ],
                    ),
                  ),
                ])
          ]))
        ],
      ),
    ));
  }
}

class ExpandableTile extends StatefulWidget {
  const ExpandableTile({super.key});

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  bool isExpanded = false;
  bool isRadius = false;
  bool isFriends = false;
  ValueNotifier<double> _currentSliderValue = ValueNotifier(20.0);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: const CustomText(text: 'Sichtbarkeit auf dem Map'),
        trailing: Switch(
          value: isExpanded,
          onChanged: (bool value) {
            setState(() {
              isExpanded = value;
            });
          },
        ),
      ),
      if (isExpanded) ...[
        const Divider(height: 0),
        ListTile(
          title: const CustomText(text: 'Nur Freunde'),
          trailing: Switch(
            value: isFriends,
            onChanged: (bool value) {
              setState(() {
                isFriends = value;
              });
            },
          ),
        ),
        const Divider(height: 0),
        ListTile(
          title: const CustomText(text: 'Radius'),
          trailing: Switch(
            value: isRadius,
            onChanged: (bool value) {
              setState(() {
                isRadius = value;
              });
            },
          ),
        ),
        if (isRadius) ...[
          ValueListenableBuilder(
              valueListenable: _currentSliderValue,
              builder: (context, value, child) {
                return ListTile(
                    title: Row(
                  children: [
                    Slider(
                      value: value,
                      max: 25,
                      divisions: 25,
                      label: value.round().toString(),
                      onChanged: (double value_) {
                        _currentSliderValue.value = value_;
                      },
                    ),
                    CustomText(text: "${value.toStringAsFixed(0)} km")
                  ],
                ));
              }),
          SizedBox(
              height: 300,
              child: RadiusSelectionMap(
                  radius: _currentSliderValue,
                  center: LatLng(52.520008, 13.404954)))
        ]
      ],
    ]);
  }
}

class RadiusSelectionMap extends StatefulWidget {
  const RadiusSelectionMap({
    super.key,
    required this.radius,
    required this.center,
  });

  final ValueNotifier<double> radius;
  final LatLng center;

  @override
  State<RadiusSelectionMap> createState() {
    return _RadiusSelectionMapState();
  }
}

class _RadiusSelectionMapState extends State<RadiusSelectionMap>
    with TickerProviderStateMixin {
  late final AnimatedMapController animatedMapController =
      AnimatedMapController(
          vsync: this,
          duration: const Duration(milliseconds: 20),
          curve: Curves.linear);

  @override
  void initState() {
    super.initState();

    widget.radius.addListener(updateZoom);
  }

  @override
  void dispose() {
    widget.radius.removeListener(updateZoom);

    super.dispose();
  }

  void updateZoom() {
    animatedMapController
        .animatedZoomTo(getZoomLevel(getCircleRadius(widget.radius.value)));
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
            zoom: getZoomLevel(getCircleRadius(widget.radius.value))),
        children: [
          createCachedTileLayer(),
          ValueListenableBuilder(
              valueListenable: widget.radius,
              builder: (context, value, child) {
                return CircleLayer(circles: <CircleMarker>[
                  CircleMarker(
                    point: widget.center,
                    color: DesignColors.blue.withOpacity(0.5),
                    borderStrokeWidth: 1,
                    borderColor: Colors.black12,
                    useRadiusInMeter: true,
                    radius: getCircleRadius(
                        widget.radius.value), // 2000 meters | 2 km
                  ),
                ]);
              })
        ],
      ),
    ]);
  }
}
