import 'package:app/constants/contants.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/body_details_screen.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    int _current = 0;

    return Scaffold(
        backgroundColor: DesignColors.kBackgroundColor,
        appBar: buildAppBar(context),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(),
        ]));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('AddLocation'),
        backgroundColor: Color.fromARGB(255, 217, 4, 4),
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
        ]);
  }
}
