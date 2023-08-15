import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class vote_rate extends StatelessWidget {
  const vote_rate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SmallText(text: "4.1"),
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
        SmallText(text: "(243)"),
      ],
    );
  }
}

class RatingScore extends StatelessWidget {
  const RatingScore({super.key, required this.score});

  final double? score;

  @override
  Widget build(BuildContext context) {
    String scoreString = score == null ? "-" : score.toString();
    return Row(children: [
      SmallText(text: scoreString),
      const Icon(
        Icons.star,
        color: Colors.amber,
        size: 15.0,
      )
    ]);
  }
}

class RatingSummary extends StatelessWidget {
  const RatingSummary({
    super.key,
    required this.count,
    required this.average,
  });

  final int? count;
  final double? average;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RatingScore(score: average),
        SmallText(text: "(${count ?? '?'})"),
      ],
    );
  }
}
