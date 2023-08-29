import 'package:app/app_state.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/number_slider.dart';
import 'package:app/widgets/radius_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:app/constants/design.dart';
import 'package:provider/provider.dart';

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
    final state = context.read<AppState>();

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
          ListeningSlider(
            min: 1,
            max: 25,
            valueNotifier: _currentSliderValue,
            textFormatter: (v) => "${v.toStringAsFixed(0)} km",
          ),
          SizedBox(
              height: 300,
              child: RadiusSelectionMap(
                  radius: _currentSliderValue,
                  center: state.userPosition ?? LatLng(52.520008, 13.404954)))
        ]
      ],
    ]);
  }
}
