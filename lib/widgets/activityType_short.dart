import 'package:app/widgets/custom/chip.dart';
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

class ActivityChip extends StatelessWidget {
  const ActivityChip(
      {super.key,
      required this.type,
      required this.onPressed,
      this.backgroundColor});

  final String type;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: CustomChip(
          backgroundColor: backgroundColor,
          text:
              type.trim(), // Entferne Leerzeichen am Anfang und Ende des Texts
        ),
      ),
    );
  }
}

class ActivityChipSlider extends StatelessWidget {
  const ActivityChipSlider(
      {super.key, required this.activities, this.onPressed});

  final List<String> activities;
  final void Function(String)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: activities.map((text) {
          return ActivityChip(
              type: text, onPressed: () => onPressed?.call(text));
        }).toList(),
      ),
    );
  }
}
