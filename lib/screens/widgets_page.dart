import 'package:app/screens/location_add.dart';
import 'package:app/screens/meet_add.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/chip.dart';
import 'package:app/widgets/custom/icon.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:app/widgets/profilecard.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return const MaterialApp(
      title: title,
      home: Scaffold(body: ProfileBar()),
    );
  }
}

class ProfileBar extends StatelessWidget {
  const ProfileBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    TextEditingController usernameController = TextEditingController();
    return CustomScrollView(slivers: <Widget>[
      SliverList(
          delegate: SliverChildListDelegate([
        Column(
          children: [
            ProfileCard(height: height),
            const SizedBox(
              width: 500, // Breite der Karte
              height: 200, // Höhe der Karte
              child: MeetCard(),
            ),
            ButtonCancel(
              onPressed: () {},
            ),
            ButtonMenu(
              onPressed: () {},
            ),
            ButtonBack(
              onPressed: () {},
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MeetAddScreen(),
                  ),
                );
              },
              text: "Add Meet2",
            ),
            CustomElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationAddScreen(),
                  ),
                );
              },
              text: "Add Meet2",
            ),
            Divider(),
            ButtonBookMark(),
            ButtonCancel(
              onPressed: () {},
            ),
            ButtonMenu(
              onPressed: () {},
            ),
            ButtonBack(
              onPressed: () {},
            ),
            CustomElevatedButton(
              onPressed: () {},
              text: "CustomElevatedButton",
            ),
            CustomTextButtonWhite(
              onPressed: () {},
              text: 'CustomTextButtonWhite',
            ),
            CustomTextButton(onPressed: () {}, text: 'CustomTextButton'),
            const CustomCard(
              child: Text("lolo"),
            ),
            CustomChip(text: "CustomChip"),
            const NaviIcon(
              icon: Icons.icecream,
              currentTab: false,
            ),
            EditIcon(),
            CustomListTile(
              onPressed: () {},
              text: "CustomListTile",
            ),
            TwoListTile(
              onPressed: () {},
              keyText: "first",
              valueText: "Secend",
            ),
            CustomTextField(
                controller: usernameController, label: "CustomTextField"),
            DescriptionTextField(
                controller: usernameController, label: "DescriptionTextField"),
            DescriptionTextFieldwithoutBorder(
                nameController: usernameController,
                label: "DescriptionTextFieldwithoutBorder"),
            PasswordTextFormField(
                controller: usernameController,
                label: "PasswordTextFormField",
                validator: (value) {}),
            CustomTextFormField(
              controller: usernameController,
              label: "CustomTextFormField",
              validator: (value) {},
            ),
            DescriptionTextFormField(
                controller: usernameController,
                hint: "DescriptionTextFormField"),
            UnderLineTextFormField(
              controller: usernameController,
              hinText: "UnderLineTextFormField",
            ),
            EmailTextFormField(
              controller: usernameController,
              label: "EmailTextFormField",
              validator: (value) {},
            ),
            UsernameTextFormField(
              controller: usernameController,
              label: "UsernameTextFormField",
              validator: (value) {},
            ),
          ],
        ),
      ])),
    ]);
  }
}
