import 'package:app/app_state.dart';
import 'package:app/model/generated.dart';
import 'package:app/constants/design.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/register.dart';

import 'package:app/screens/settings/password.dart';
import 'package:app/screens/settings/email.dart';
import 'package:app/screens/settings/name.dart';
import 'package:app/screens/settings/privacy.dart';
import 'package:app/widgets/custom/card.dart';
import 'package:app/widgets/custom/icon.dart';
import 'package:app/widgets/custom/list_tile.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;
    var size = MediaQuery.of(context).size;

    double width = size.width;
    final state = Provider.of<AppState>(context);

    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          expandedHeight: expandedHeight,
          collapsedHeight: collapsedHeight,
          pinned: true,
          backgroundColor: DesignColors.kBackgroundColor,
          leading: state.isLoggedIn
              ? null
              : CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  text: "Login"),
          actions: <Widget>[
            if (state.isLoggedIn)
              CustomTextButton(
                  onPressed: () => handleLogout(context), text: 'logout')
            else
              CustomTextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                ),
                text: 'Register',
              ),
          ],
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FlexibleSpaceBar(
                //ToDo error beim scrollen
                titlePadding: const EdgeInsets.all(16.0),
                title: state.isLoggedIn
                    ? _appBarAvatar(context)
                    : const CustomText(
                        text: "Not signed in!",
                      ),
                centerTitle: true,
              );
            },
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (state.isLoggedIn)
                  ..._accountSettings(context, state.currentUser!),
                ..._appSettings(context),
                ..._legalSettings(context)
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MediumHintText(
                  text: "App-Version: Beta",
                  width: width,
                ),
                if (state.isLoggedIn) ...[
                  CustomTextButton(
                    text: 'logout',
                    onPressed: () => handleLogout(context),
                  ),
                  CustomTextButton(
                    text: 'Konto löschen',
                    onPressed: () {},
                  ),
                ]
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
                child: Container(
                  height: 70.0,
                )),
          ]),
        )
      ]),
    );
  }

  Widget _appBarAvatar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(alignment: Alignment.center, children: [
          avatarFutureBuilder(context: context, radius: 40),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DisplayNameSwitch(),
                  ),
                );
              },
              child: const EditIcon(),
            ),
          ),
        ]),
      ],
    );
  }

  List<Widget> _accountSettings(BuildContext context, UserDetailed userInfo) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
        child: LittleText(
          text: "Konto",
          width: width,
        ),
      ),
      CustomCard(
        child: Column(
          children: [
            CustomListTile(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DisplayNameSwitch(),
                    ),
                  );
                },
                titleText: "Username and Displayname"),
            const Divider(height: 0),
            TwoListTile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DisplayNameSwitch(),
                  ),
                );
              },
              keyText: "Displayname",
              valueText: userInfo.displayName,
            ),
            const Divider(height: 0),
            TwoListTile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailSwitch(),
                  ),
                );
              },
              keyText: "E-Mail",
              valueText: userInfo.authentication.email ?? "none@none.com",
            ),
            const Divider(height: 0),
            CustomListTile(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PasswordSwitch(),
                    ),
                  );
                },
                titleText: "Password"),
            const Divider(height: 0),
            CustomListTile(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacySettingPage(),
                    ),
                  );
                },
                titleText: "Privacy"),
          ],
        ),
      ),
    ];
  }

  List<Widget> _appSettings(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
        child: LittleText(
          text: "App",
          width: width,
        ),
      ),
      CustomCard(
        child: Column(children: [
          TwoListTile(
            onPressed: () {},
            keyText: 'Language',
            valueText: 'English',
          ),
          const Divider(height: 0),
          CustomListTile(onPressed: () {}, titleText: "Map"),
          const Divider(height: 0),
          CustomListTile(onPressed: () {}, titleText: "Farbe"),
        ]),
      )
    ];
  }

  List<Widget> _legalSettings(BuildContext context) {
    var size = MediaQuery.of(context).size;

    double width = size.width;
    return [
      Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, bottom: 4),
        child: LittleText(
          text: "Rechtliche",
          width: width,
        ),
      ),
      CustomCard(
        child: Column(
          children: [
            CustomListTile(onPressed: () {}, titleText: "data protection"),
            const Divider(height: 0),
            CustomListTile(onPressed: () {}, titleText: "AGB"),
            const Divider(height: 0),
            CustomListTile(onPressed: () {}, titleText: "Impressum"),
          ],
        ),
      )
    ];
  }
}

class PhotoShower extends StatelessWidget {
  const PhotoShower({super.key, required this.image, required this.photoName});

  final MemoryImage image;
  final String photoName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.kBackgroundColor,
      appBar: AppBar(
          backgroundColor: DesignColors.naviColor,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(AppIcons.keyboardBackspace),
              color: DesignColors.kBackgroundColor,
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: const <Widget>[]),
      body: Image(image: image),
    );
  }
}

void handleLogout(BuildContext context) {
  Provider.of<AppState>(context, listen: false).logout();
  TokenManager.instance.deleteToken();
  showMessageSnackBar(context, 'Logged out!');
}
