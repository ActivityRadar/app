import 'package:app/widgets/custom_chip.dart';
import 'package:flutter/material.dart';

class ActivityDetails extends StatelessWidget {
  const ActivityDetails({
    super.key,
    required this.imageurl,
    required this.lat,
    required this.long,
    required this.titel,
    required this.press,
  });

  final String imageurl;
  final double lat;
  final double long;
  final String titel;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return GestureDetector(
        onTap: press,
        child: const Column(
          children: [
            Row(
              children: [
                CustomChip(text: " Table Tennis"),
                CustomChip(text: " Table Tennis"),
                CustomChip(text: " Table Tennis")
              ],
            )
          ],
        ));
  }

  myDetailsContainer({required id}) {}
}
