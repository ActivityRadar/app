import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationIcon extends StatelessWidget {
  const LocationIcon({
    super.key,
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        'assets/icons/location_icon.svg', // Pfad zur SVG-Datei
        color: color,
        height: size,
        semanticsLabel: 'location');
  }
}
