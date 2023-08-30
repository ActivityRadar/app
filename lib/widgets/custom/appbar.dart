import 'package:app/constants/design.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:flutter/material.dart';

AppBar CustomAppBar(BuildContext context, VoidCallback onPressed) {
  return AppBar(
      elevation: 0.0,
      backgroundColor: DesignColors.transparent,
      leading: ButtonCircle(icon: AppIcons.close, onPressed: onPressed));
}

AppBar CustomWithActionAppBar(BuildContext context,
    VoidCallback onPressedleading, VoidCallback onPressedactions) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: DesignColors.transparent,
    leading: ButtonCircle(icon: AppIcons.close, onPressed: onPressedleading),
    actions: [ButtonCircle(icon: AppIcons.done, onPressed: onPressedactions)],
  );
}
