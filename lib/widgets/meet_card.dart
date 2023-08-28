import 'package:app/constants/constants.dart';
import 'package:app/model/generated.dart';
import 'package:app/screens/meet_page.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:app/widgets/custom/chip.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MeetCard extends StatelessWidget {
  const MeetCard({
    super.key,
    required this.offer,
  });

  final OfferOut offer;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MeetPage(),
            ),
          );
        },
        child: SizedBox(
            width: width,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
                ),
                child: Column(
                  children: [
                    Stack(children: [
                      SizedBox(
                        height: height / 6.5,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppStyle
                                  .cornerRadius), // Radius der abgerundeten Ecken
                            ),
                            child: const MeetMap(center: LatLng(53, 12))),
                      ),
                      Positioned(
                          bottom:
                              0, // Positioniert den Container am unteren Rand
                          left: 0,
                          right: 0,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12.0),
                                    child: ActivityChip(
                                      type: offer.activity.length != 1
                                          ? "Multi"
                                          : offer.activity[0],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: CustomChip(
                                      text: 'ab 14 Uhr ',
                                    ),
                                  )
                                ],
                              ))),
                    ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 10, top: 60)),
                              CircleAvatar(
                                backgroundImage: AssetImages.avatarEmpty,
                                radius: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              MediumText(
                                text: 'Max Mustermann',
                                width: width,
                              ),
                            ]),
                          ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: LittleText(
                                    text: "12h ago",
                                    width: width,
                                  ),
                                )
                              ]),
                        ]),
                  ],
                ))));
  }
}
