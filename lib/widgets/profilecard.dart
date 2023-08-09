import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage(
                      'assets/locationPhotoLoadingPlaceholder.jpg'), // Beispielbild
                  radius: 43,
                ),
                const SizedBox(width: 0.5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Max Mustermann',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black54),
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
                      const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Row(children: [
                            Text(
                              'Level: 5',
                              style: TextStyle(fontSize: 10),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: 2),
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
