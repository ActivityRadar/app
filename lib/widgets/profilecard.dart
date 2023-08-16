import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    double width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height / 25, horizontal: 16.0),
      child: SizedBox(
        height: 66, // Höhe der Karte
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImages.locationLoading,
                  radius: 43,
                ),
                const SizedBox(width: 0.5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LittleText(
                        text: 'Max Mustermann',
                        width: width,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(215, 255, 255, 255),
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 0.1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 10,
                        width: 180.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              width: 10.0,
                              decoration: const BoxDecoration(
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
                          padding: EdgeInsets.only(top: 2),
                          child: Row(children: [
                            LittleText(
                              text: 'Level: 5',
                              width: width * 0.8,
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: LittleText(
                                text: 'Level: 6',
                                width: width * 0.8,
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
