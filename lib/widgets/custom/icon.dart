import 'package:app/constants/design.dart';
import 'package:flutter/material.dart';

class NaviIcon extends StatelessWidget {
  const NaviIcon({
    super.key,
    required this.icon,
    required this.currentTab,
  });

  final bool currentTab;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: currentTab ? DesignColors.naviColor : Colors.grey);
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
        radius: 8,
        backgroundColor: DesignColors.naviColor,
        child: Center(
          child: Icon(
            AppIcons.edit,
            size: 8,
          ),
        ));
  }
}

class IconBack extends StatelessWidget {
  const IconBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back,
      color: DesignColors.naviColor,
    );
  }
}
