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
      padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MediumText(
                        text: 'Max Mustermann',
                        width: width,
                      ),
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
