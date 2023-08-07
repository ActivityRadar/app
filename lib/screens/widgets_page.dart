import 'package:app/constants/constants.dart';
import 'package:app/screens/settings_name.dart';
import 'package:app/widgets/vote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WidgetsGird extends StatelessWidget {
  const WidgetsGird({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(body: ProfilBar()),
    );
  }
}

class ProfilBar extends StatelessWidget {
  const ProfilBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ProfilCard(height: height),
            Container(
              width: 500, // Breite der Karte
              height: 200, // Höhe der Karte
              child: MeetCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetCard extends StatelessWidget {
  const MeetCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MeetPage(),
            ),
          );
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
            ),
            child: Column(
              children: [
                Stack(children: [
                  SizedBox(
                    height: 130,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppStyle
                              .cornerRadius), // Radius der abgerundeten Ecken
                        ),
                        child: MeetMap(
                          height: 10,
                          width: 10,
                        )),
                  ),
                  Positioned(
                      bottom: 0, // Positioniert den Container am unteren Rand
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 12.0),
                                child: Chip(
                                    label: Text(
                                      "Table Tennis",
                                      style: TextStyle(
                                          color: DesignColors.kBackgroundColor,
                                          fontSize: 10),
                                    ),
                                    backgroundColor: DesignColors.naviColor),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Chip(
                                      label: Text(
                                        "ab 14 Uhr",
                                        style: TextStyle(
                                            color:
                                                DesignColors.kBackgroundColor,
                                            fontSize: 10),
                                      ),
                                      backgroundColor: DesignColors.naviColor)),
                            ],
                          ))),
                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Row(children: [
                          Padding(padding: EdgeInsets.only(left: 10, top: 60)),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/locationPhotoLoadingPlaceholder.jpg'), // Beispielbild
                            radius: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Anton Kriese',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black54),
                          ),
                        ]),
                      ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "12h ago",
                                style: TextStyle(
                                    color: Colors.black38, fontSize: 11),
                              ),
                            )
                          ]),
                    ]),
              ],
            )));
  }
}

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuCard extends StatefulWidget {
  const PopupMenuCard({super.key});

  @override
  State<PopupMenuCard> createState() => _PopupMenuCardState();
}

class _PopupMenuCardState extends State<PopupMenuCard> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Item 1'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text('Item 2'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: Text('Item 3'),
        ),
      ],
    );
  }
}

class ProfilCard extends StatelessWidget {
  const ProfilCard({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 25, horizontal: 16.0),
      child: Container(
        height: 66, // Höhe der Karte
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/locationPhotoLoadingPlaceholder.jpg'), // Beispielbild
                  radius: 43,
                ),
                SizedBox(width: 0.5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anton Kriese',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(215, 255, 255, 255),
                          border: Border.all(
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 0.1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 10,
                        width: 220.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 10.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Row(children: [
                            Text(
                              'Level: 5',
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(width: 160),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                'Level: 6',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ])),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MeetMap extends StatefulWidget {
  const MeetMap({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<MeetMap> createState() {
    return _MeetMapState();
  }
}

class _MeetMapState extends State<MeetMap> {
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
        radius: 200, // 2000 meters | 2 km
      ),
    ];
    return Stack(children: [
      IgnorePointer(
        child: FlutterMap(
          options: MapOptions(center: center, zoom: 10),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            CircleLayer(circles: circleMarkers),
          ],
        ),
      )
    ]);
  }
}

class MeetPage extends StatelessWidget {
  const MeetPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              child: const Text('loggout'),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            //ToDo error beim scrollen

            background: SizedBox(
              height: 130,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        AppStyle.cornerRadius), // Radius der abgerundeten Ecken
                  ),
                  child: MeetMap(
                    height: 10,
                    width: 10,
                  )),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Row(children: [
                      Padding(padding: EdgeInsets.only(left: 10, top: 60)),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/locationPhotoLoadingPlaceholder.jpg'), // Beispielbild
                        radius: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Anton Kriese',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ]),
                  ]),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "12h ago",
                        style: TextStyle(color: Colors.black38, fontSize: 11),
                      ),
                    )
                  ]),
                ]),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[]),
          ]),
        )
      ]),
    );
  }
}
