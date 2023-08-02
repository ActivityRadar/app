import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/vote.dart';

class ActivityDetails extends StatelessWidget {
  const ActivityDetails({
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
    var width = size.width;
    return GestureDetector(
      onTap: press,
      child: FittedBox(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(25.0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                  child: Text(
                    'Table Tennis',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
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
    double width = size.width;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: press,
          child: FittedBox(
            child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: width * 2,
                    height: 200,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                      child: Text(
                        'Table Tennis',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  myDetailsContainer({required id}) {}
}
