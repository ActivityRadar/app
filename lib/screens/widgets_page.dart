import 'package:app/constants/constants.dart';
import 'package:app/screens/meet_add.dart';
import 'package:app/screens/meet_page.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:app/widgets/profilcard.dart';
import 'package:flutter/material.dart';

class WidgetsGird extends StatelessWidget {
  const WidgetsGird({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return const MaterialApp(
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
            const SizedBox(
              width: 500, // Breite der Karte
              height: 200, // Höhe der Karte
              child: MeetCard(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMeet(),
                  ),
                );
              },
              child: Text('Add Meet'),
            ),
          ],
        ),
      ),
    );
  }
}
