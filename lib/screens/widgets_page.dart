import 'package:app/screens/location_add.dart';
import 'package:app/screens/meet_add.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/chip.dart';
import 'package:app/widgets/custom/icon.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/widgets/login_reminder.dart';
import 'package:app/widgets/meet_card.dart';
import 'package:app/widgets/profilecard.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/design.dart';
import 'package:flutter_svg/svg.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return const MaterialApp(
      title: title,
      home: Scaffold(
        body: BackgroundSVG(
          children: ProfileBar(),
        ),
      ),
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
    double x = 20;
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
              // child: MeetCard(),
            ),
            ButtonCircle(
              icon: AppIcons.close,
              onPressed: () {},
            ),
            ButtonCircle(
              icon: AppIcons.menu,
              onPressed: () {},
            ),
            ButtonCircle(
              icon: AppIcons.arrowBack,
              onPressed: () {},
            ),
            CustomElevatedButton(
              onPressed: () {
                conditionalShowLoginReminder(
                    context: context,
                    loggedInCallback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MeetAddScreen(),
                        ),
                      );
                    });
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
            SizedBox(height: x),
            ButtonCircle(
              icon: AppIcons.close,
              onPressed: () {},
            ),
            SizedBox(height: x),
            ButtonCircle(
              icon: AppIcons.menu,
              onPressed: () {},
            ),
            SizedBox(height: x),
            ButtonCircle(
              icon: AppIcons.arrowBack,
              onPressed: () {},
            ),
            SizedBox(height: x),
            CustomElevatedButton(
              onPressed: () {},
              text: "CustomElevatedButton",
            ),
            SizedBox(height: x),
            CustomTextButtonWhite(
              onPressed: () {},
              text: 'CustomTextButtonWhite',
            ),
            CustomTextButton(onPressed: () {}, text: 'CustomTextButton'),
            SizedBox(height: x),
            CustomCard(
                child: Column(
              children: [
                CustomListTile(
                  onPressed: () {},
                  text: "CustomListTile",
                ),
                Text("CustomCard"),
              ],
            )),
            SizedBox(height: x),
            CustomChip(text: "CustomChip"),
            SizedBox(height: x),
            const NaviIcon(
              icon: Icons.icecream,
              currentTab: false,
            ),
            EditIcon(),
            SizedBox(height: x),
            CustomListTile(
              onPressed: () {},
              text: "CustomListTile",
            ),
            SizedBox(height: x),
            TwoListTile(
              onPressed: () {},
              keyText: "first",
              valueText: "Secend",
            ),
            SizedBox(height: x),
            CustomTextField(
                controller: usernameController, label: "CustomTextField"),
            SizedBox(height: x),
            DescriptionTextField(
                controller: usernameController, label: "DescriptionTextField"),
            SizedBox(height: x),
            DescriptionTextFieldwithoutBorder(
                nameController: usernameController,
                label: "DescriptionTextFieldwithoutBorder"),
            SizedBox(height: x),
            PasswordTextFormField(
                controller: usernameController,
                label: "PasswordTextFormField",
                validator: (value) {}),
            SizedBox(height: x),
            CustomTextFormField(
              controller: usernameController,
              label: "CustomTextFormField",
              validator: (value) {},
            ),
            SizedBox(height: x),
            DescriptionTextFormField(
                controller: usernameController,
                label: "DescriptionTextFormField"),
            SizedBox(height: x),
            UnderLineTextFormField(
              controller: usernameController,
              label: "UnderLineTextFormField",
            ),
            SizedBox(height: x),
            EmailTextFormField(
              controller: usernameController,
              label: "EmailTextFormField",
              validator: (value) {},
            ),
            SizedBox(height: x),
            UsernameTextFormField(
              controller: usernameController,
              label: "UsernameTextFormField",
              validator: (value) {},
            ),
            SizedBox(height: 120),
          ],
        ),
      ])),
    ]);
  }
}
