import 'package:app/constants/constants.dart';
import 'package:app/screens/meet_add.dart';
import 'package:app/screens/meet_page.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:app/widgets/meet_map.dart';
import 'package:app/widgets/profilecard.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return const MaterialApp(
      title: title,
      home: Scaffold(body: ProfileBar()),
    );
  }
}

class ProfileBar extends StatelessWidget {
  const ProfileBar({
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
            ProfileCard(height: height),
            const SizedBox(
              width: 500, // Breite der Karte
              height: 200, // Höhe der Karte
              child: MeetCard(),
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddMeet(),
                  ),
                );
              },
              text: "Add Meet",
            ),
          ],
        ),
      ),
    );
  }
}
