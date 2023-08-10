import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PrivacySettingPage extends StatefulWidget {
  const PrivacySettingPage({super.key});

  @override
  State<PrivacySettingPage> createState() => _PrivacySettingPageState();
}

class _PrivacySettingPageState extends State<PrivacySettingPage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              title: const Text("Privacy"),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.navigate_before))),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 15, bottom: 4),
                    child: Text(
                      "Profil",
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(51, 241, 241, 241),
                      ),
                      borderRadius:
                          BorderRadius.circular(AppStyle.cornerRadius),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('öffentliches Profil'),
                          trailing: Switch(
                            // This bool value toggles the switch.
                            value: isExpanded,
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                isExpanded = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 15, bottom: 4),
                    child: Text(
                      "Angebot",
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(51, 241, 241, 241),
                      ),
                      borderRadius:
                          BorderRadius.circular(AppStyle.cornerRadius),
                    ),
                    child: const Column(
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppStyle.cornerRadius),
                topRight: Radius.circular(AppStyle.cornerRadius))),
        title: const Text('Sichtbarkeit auf dem Map'),
        trailing: Switch(
          // This bool value toggles the switch.
          value: isExpanded,
          activeColor: Colors.red,
          onChanged: (bool value) {
            // This is called when the user toggles the switch.
            setState(() {
              isExpanded = value;
            });
          },
        ),
      ),
      if (isExpanded) ...[
        const Divider(height: 0),
        ListTile(
          title: const Text('Nur Freunde'),
          trailing: Switch(
            // This bool value toggles the switch.
            value: isfriends,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                isfriends = value;
              });
            },
          ),
        ),
        const Divider(height: 0),
        ListTile(
          title: const Text('Radius'),
          trailing: Switch(
            // This bool value toggles the switch.
            value: isRadius,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
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
              Text(_currentSliderValue.toString())
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
        // Weitere ListTile hier hinzufügen
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
  LatLngBounds bounds = LatLngBounds(LatLng(52.37, 12.74), LatLng(50, 13.04));
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final LatLng center = LatLng(52.520008, 13.404954); //Todo center
    final circleMarkers = <CircleMarker>[
      CircleMarker(
        point: center,
        color: Colors.blue.withOpacity(0.5),
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
