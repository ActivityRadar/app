import 'package:app/constants/constants.dart';
import 'package:app/model/functions.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/photos.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/vote.dart';

class ShortInfoBox extends StatelessWidget {
  const ShortInfoBox({
    super.key,
    required this.info,
    required this.onPressed,
  });

  final LocationDetailedApi? info;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final height = constraints.maxHeight;
      final width = constraints.maxWidth;
      print("$height, $width");

      final thumbnailDiameter = height;
      final infoWidth = width - height;

      late Future thumbnail;
      if (info == null || info!.photos.isEmpty) {
        thumbnail = Future.value(
            const AssetImage("assets/locationPhotoPlaceholder.jpg"));
      } else {
        thumbnail = PhotoManager.instance.getThumbnail(info!.photos[0].url);
      }
      return GestureDetector(
        onTap: onPressed,
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            borderRadius: BorderRadius.circular(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: thumbnailDiameter,
                  height: thumbnailDiameter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: FutureBuilder(
                      future: thumbnail,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Image(
                            fit: BoxFit.fill,
                            image: snapshot.data,
                          );
                        } else {
                          return const Image(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/locationPhotoLoadingPlaceholder.jpg"));
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                    height: height,
                    width: infoWidth,
                    child: InfoContainer(info: info))
              ],
            ),
          ),
        ),
      );
    });
  }
}

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    super.key,
    required this.info,
  });

  final LocationDetailedApi? info;

  @override
  Widget build(BuildContext context) {
    var count, avg, title;
    if (info != null) {
      count = info!.reviews.count;
      avg = info!.reviews.averageRating;
      title = getTitle(info!);
    } else {
      count = null;
      avg = null;
      title = "action";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: DesignColors.naviColor,
                // fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
        RatingSummary(count: count, average: avg),
        const Spacer(),
        const Text(
          "KM entfernt",
          style: TextStyle(
              color: Colors.black54,
              // fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        const Spacer(),
      ],
    );
  }
}
