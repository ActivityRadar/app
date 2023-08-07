// ignore_for_file: avoid_print

import 'package:app/constants/constants.dart';
import 'package:app/screens/location_picker.dart';
import 'package:app/widgets/filter_discipline.dart';
import 'package:flutter/material.dart';

Future<dynamic> bottomSheetBase(
    {required BuildContext context, required dynamic builder}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
                onTap: () {
                  writeReview(context);
                },
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
              const FilterDiscipline(),
            ],
          ));
}

Future<dynamic> writeReview(BuildContext context) {
  var rating = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  return bottomSheetBase(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 9.0, top: 9.0),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const Text(
                      "Review",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Send'), //TODO backend
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: index < rating
                            ? const Icon(Icons.star, size: 32)
                            : const Icon(Icons.star_border, size: 32),
                        color: DesignColors.naviColor,
                        onPressed: () {
                          setState(() {
                            rating = index + 1;
                            print(rating);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: usernameController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: 'Titel',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                TextFormField(
                  maxLines: 5,
                  controller: desController,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    hintText: 'Beschreibung',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ));
      });
}

void setState(Null Function() param0) {}
