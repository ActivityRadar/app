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
      Text(
        scoreString,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
      ),
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

  final int count;
  final double? average;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RatingScore(score: average),
        Text(
          "($count)",
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        )
      ],
    );
  }
}
