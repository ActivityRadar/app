import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[CustomText(text: "Hallo")],
          )
        ],
      ),
    );
  }
}
