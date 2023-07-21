import 'package:app/constants/contants.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/body_details_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.locationId});

  final String locationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.kBackgroundColor,
      appBar: buildAppBar(context),
      body: const BodyDetails(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: DesignColors.naviColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace),
            color: DesignColors.kBackgroundColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share),
            color: DesignColors.kBackgroundColor,
          ),
          IconButton(
            onPressed: () => bottomSheetPhotoSourcePicker(
                context: context, mode: "location", locationId: locationId),
            icon: const Icon(Icons.add_a_photo),
            color: DesignColors.kBackgroundColor,
          ),
        ]);
  }
}
