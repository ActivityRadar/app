import 'package:app/widgets/custom/icon.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const CustomText(text: "Privacy"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconBack(),
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
    );
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
  bool isfriends = false;
  double _currentSliderValue = 20;
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
            value: isfriends,
            onChanged: (bool value) {
              setState(() {
                isfriends = value;
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
          ListTile(
              title: Row(
            children: [
              Slider(
                value: _currentSliderValue,
                max: 25,
                divisions: 25,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              CustomText(text: _currentSliderValue.toString())
            ],
          )),
          SizedBox(
              height: 300,
              child: RadiusSelectionMap(
                height: 10,
                width: 10,
                radius: _currentSliderValue,
              ))
        ]
      ],
    ]);
  }
}

class RadiusSelectionMap extends StatefulWidget {
  const RadiusSelectionMap({
    super.key,
    required this.radius,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<RadiusSelectionMap> createState() {
    return _RadiusSelectionMapState();
  }
}

class _RadiusSelectionMapState extends State<RadiusSelectionMap> {
  LatLngBounds bounds =
      LatLngBounds(const LatLng(52.37, 12.74), const LatLng(50, 13.04));
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    const LatLng center = LatLng(52.520008, 13.404954); //Todo center
    final circleMarkers = <CircleMarker>[
      CircleMarker(
        point: center,
        color: DesignColors.blue.withOpacity(0.5),
        borderStrokeWidth: 1,
        borderColor: Colors.black12,
        useRadiusInMeter: true,
        radius: widget.radius * 1000, // 2000 meters | 2 km
      ),
    ];
    return Stack(children: [
      FlutterMap(
        mapController: mapController,
        options: MapOptions(center: center, zoom: 10),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          CircleLayer(circles: circleMarkers),
        ],
      ),
    ]);
  }
}
