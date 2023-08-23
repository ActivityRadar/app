import 'package:app/widgets/activityType_short.dart';
import 'package:flutter/material.dart';

class ActivitySearchChipSlider extends StatelessWidget {
  const ActivitySearchChipSlider(
      {super.key, required this.activities, this.onPressed});

  final List<String> activities;
  final void Function(String)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: activities.map((text) {
          return ActivityChip(type: text, onPressed: () {});
        }).toList(),
      ),
    );
  }
}
