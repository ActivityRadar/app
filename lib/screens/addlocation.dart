import 'package:app/constants/design.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
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
                  title:
                      PageTitleText(width: width, text: 'Location proposal')),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: MediumText(text: "Name", width: width)),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: CustomTextField(
                    streetController: nameController,
                    label: "Name",
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: MediumText(text: "Adresse", width: width)),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: CustomTextField(
                          streetController: streetController,
                          label: "Street",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: CustomTextField(
                          streetController: streetController,
                          label: "house number ",
                        ),
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
                        child: CustomTextField(
                          streetController: streetController,
                          label: "City",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: CustomTextField(
                          streetController: streetController,
                          label: "zip code",
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: TitleText(text: 'activityType', width: width)),
                const FilterDiscipline(),
                Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: TitleText(text: 'description', width: width)),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: DescriptionTextField(
                    streetController: nameController,
                    label: "description",
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
                    child: const SmallText(
                      text: "Bilder hochladen",
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 9.0, top: 15.0),
                    child: MediumText(
                      text: "review",
                      width: width,
                    )),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: index < _rating
                            ? const Icon(Icons.star, size: 32)
                            : const Icon(Icons.star_border, size: 32),
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
        title: const SmallText(text: 'AddLocation'),
        backgroundColor: const Color.fromARGB(255, 217, 4, 4),
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
