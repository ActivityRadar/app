import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundSVG extends StatelessWidget {
  const BackgroundSVG({
    super.key,
    required this.children,
  });

  final Widget children;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Transform.scale(
        scale: 4.0, // Zoomfaktor

        child: SvgPicture.asset("assets/images/background.svg",
            colorFilter: ColorFilter.mode(
                Color.fromARGB(66, 192, 195, 243), BlendMode.srcIn),
            semanticsLabel: 'BackgroundDetails Screen'),
      ),
      children
    ]);
  }
}
