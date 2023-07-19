import 'package:app/screens/addlocation.dart';
import 'package:flutter/material.dart';

Future<dynamic> BottomSheetAdd(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.push_pin),
                title: const Text("Add Location"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddLocation(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Add Event"),
                onTap: () {},
              ),
            ],
          ));
}

Future<dynamic> BottomSheetFilter(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 9.0, top: 9.0),
                        child: TextButton(
                          onPressed: () {
                            print("Moin");
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      print("Moin");
                    },
                    child: const Text('filter'),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text("Add Event"),
                onTap: () {},
              ),
            ],
          ));
}
