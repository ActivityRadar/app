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

class vote_rate_small extends StatelessWidget {
  const vote_rate_small({
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
