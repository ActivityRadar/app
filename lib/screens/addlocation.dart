import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';
import 'package:app/widgets/custom_textbutton.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:flutter/material.dart';
import '../widgets/filter_discipline.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});
  @override
  State<AddLocation> createState() => _AddLocation();
}

class _AddLocation extends State<AddLocation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var _rating = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;

    return Scaffold(
        backgroundColor: DesignColors.kBackgroundColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.0),
                ),
              ),
              shadowColor: DesignColors.kBackgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    print("LOLO");
                  },
                ),
              ],
              pinned: true,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'Location proposal',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: width * 0.06),
                  )),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "Name",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                      controller: nameController,
                      onChanged: (v) => nameController.text = v,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(209, 155, 203, 241),
                        labelText: 'Name',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "Adresse",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextField(
                            controller: streetController,
                            onChanged: (v) => streetController.text = v,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(209, 155, 203, 241),
                              labelText: 'Street',
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextField(
                            controller: streetController,
                            onChanged: (v) => streetController.text = v,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(209, 155, 203, 241),
                              labelText: 'house number ',
                            )),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextField(
                            controller: streetController,
                            onChanged: (v) => streetController.text = v,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(209, 155, 203, 241),
                              labelText: 'City',
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: TextField(
                            controller: streetController,
                            onChanged: (v) => streetController.text = v,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(209, 155, 203, 241),
                              labelText: 'zip code ',
                            )),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "activityType",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.05),
                  ),
                ),
                FilterDiscipline(),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "description",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: nameController,
                    onChanged: (v) => nameController.text = v,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(209, 155, 203, 241),
                      labelText: 'description',
                    ),
                    maxLines: 3,
                    minLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextButton(
                    onPressed: () => bottomSheetPhotoSourcePicker(
                        context: context,
                        mode: "location",
                        locationId: 'asdas'),
                    //TODO
                    child: const Text("Bilder hochladen"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                  child: Text(
                    "review",
                    style: TextStyle(
                        color: const Color.fromARGB(182, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: width * 0.04),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: index < _rating
                            ? Icon(Icons.star, size: 32)
                            : Icon(Icons.star_border, size: 32),
                        color: DesignColors.naviColor,
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                            print(_rating);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: CustomTextButton(onPressed: () {}, text: 'Absenden'),
                ),
              ]),
            ),
          ],
        ));
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
