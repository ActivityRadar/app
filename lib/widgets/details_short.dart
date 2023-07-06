import 'package:app/constants/contants.dart';
import 'package:flutter/material.dart';

class BoxesDetails extends StatelessWidget {
  const BoxesDetails({
    super.key,
    required this.imageurl,
    required this.lat,
    required this.long,
    required this.titel,
    required this.press,
  });

  final String imageurl;
  final double lat;
  final double long;
  final String titel;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return GestureDetector(
      onTap: press,
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 180,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageurl),
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

  myDetailsContainer({required id}) {}
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
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "4.1",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 15.0,
            ),
            Icon(
              Icons.star_half_sharp,
              color: Colors.amber,
              size: 15.0,
            ),
            Text(
              "(243)",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )
          ],
        ),
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
