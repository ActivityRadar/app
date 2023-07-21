import 'package:app/constants/contants.dart';
import 'package:app/providers/photos.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final PhotoService ps = PhotoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: () async {
                const String photoLink = "logo.png";
                MemoryImage photo = await ps.getPhoto(photoLink);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoShower(image: photo, photoName: photoLink),
                    ),
                  );
                }
              }),
        ],
      ),
    ));
  }
}

class PhotoShower extends StatelessWidget {
  const PhotoShower({super.key, required this.image, required this.photoName});

  final MemoryImage image;
  final String photoName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.kBackgroundColor,
      appBar: AppBar(
          backgroundColor: DesignColors.naviColor,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.keyboard_backspace),
              color: DesignColors.kBackgroundColor,
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[]),
      body: Image(image: image),
    );
  }
}
