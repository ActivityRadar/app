import 'package:app/constants/constants.dart';
import 'package:app/screens/meet_page.dart';
import 'package:app/widgets/meet_map.dart';

import 'package:flutter/material.dart';

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
                        child: const MeetMap()),
                  ),
                  Positioned(
                      bottom: 0, // Positioniert den Container am unteren Rand
                      left: 0,
                      right: 0,
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          child: const Row(
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
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Row(children: [
                          Padding(padding: EdgeInsets.only(left: 10, top: 60)),
                          CircleAvatar(
                            backgroundImage: AssetImages.avatarEmpty,
                            radius: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Max Mustermann',
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
