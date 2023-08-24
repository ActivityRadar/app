import 'package:app/constants/constants.dart';
import 'package:app/widgets/activityType_short.dart';
import 'package:flutter/material.dart';

class ProfilCircle extends StatelessWidget {
  const ProfilCircle(
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
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImages.avatarEmpty,
              radius: 35,
            ),
            Text(type.trim())
          ],
        ),
      ),
    );
  }
}

class ProfilSlider extends StatelessWidget {
  const ProfilSlider({super.key, required this.profil, this.onPressed});

  final List<String> profil;
  final void Function(String)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: profil.map((text) {
          return ProfilCircle(type: text, onPressed: () {});
        }).toList(),
      ),
    );
  }
}
