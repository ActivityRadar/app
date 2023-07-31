import 'package:app/constants/contants.dart';
import 'package:app/provider/photos.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/vote.dart';

class BoxesDetails extends StatelessWidget {
  const BoxesDetails({
    super.key,
    this.imageUrl,
    required this.titel,
    required this.onPressed,
  });

  final String? imageUrl;
  final String titel;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    late Future thumbnail;
    if (imageUrl == null) {
      thumbnail =
          Future.value(const AssetImage("assets/locationPhotoPlaceholder.jpg"));
    } else {
      thumbnail = PhotoManager.instance.getPhoto(imageUrl!);
    }
    return GestureDetector(
      onTap: onPressed,
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 180,
                height: 200,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DetailContainer(titel: titel),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    super.key,
    required this.titel,
  });

  final String titel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            titel,
            style: const TextStyle(
                color: DesignColors.naviColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        const vote_rate(),
        const SizedBox(height: 5.0),
        const Text(
          "KM entfernt",
          style: TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
