import 'package:app/screens/location_picker.dart';
import 'package:app/widgets/filter_discipline.dart';
import 'package:flutter/material.dart';

Future<dynamic> bottomSheetBase(
    {required BuildContext context, required dynamic builder}) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: builder);
}

Future<dynamic> bottomSheetAdd(BuildContext context) {
  return bottomSheetBase(
      context: context,
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
                      builder: (context) => const LocationPickerMap(),
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

Future<dynamic> bottomSheetFilter(BuildContext context) {
  return bottomSheetBase(
      context: context,
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
                        padding: const EdgeInsets.only(left: 9.0, top: 9.0),
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
              FilterDiscipline(),
            ],
          ));
}
