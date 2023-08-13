import 'package:app/app_state.dart';
import 'package:app/constants/constants.dart';
import 'package:app/model/generated.dart';
import 'package:app/constants/design.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/auth.dart';
import 'package:app/screens/setting_password.dart';
import 'package:app/screens/settings_email.dart';
import 'package:app/screens/settings_name.dart';
import 'package:app/screens/settings_privacy.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:app/widgets/custom_textbutton.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double collapsedHeight = 90;
    const double expandedHeight = 160;

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
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  text: "Login"),
          actions: <Widget>[
            if (state.isLoggedIn)
              CustomTextButton(
                  onPressed: () => handleLogout(context), text: 'logout')
          ],
          flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FlexibleSpaceBar(
                //ToDo error beim scrollen
                titlePadding: const EdgeInsets.all(16.0),
                title: state.isLoggedIn
                    ? _appBarAvatar(context)
                    : const Text("Not signed in!",
                        style: TextStyle(color: Colors.black)),
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
                const Text("App-Version: Beta",
                    style: TextStyle(color: Colors.black45)),
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
              child: const CircleAvatar(
                  radius: 8,
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 8,
                    ),
                  )),
            ),
          ),
        ]),
      ],
    );
  }

  List<Widget> _accountSettings(BuildContext context, UserDetailed userInfo) {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 8, left: 15, bottom: 4),
        child: Text(
          "Konto",
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(51, 241, 241, 241),
          ),
          borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
        ),
        child: Column(
          children: [
            ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppStyle.cornerRadius),
                      topRight: Radius.circular(AppStyle.cornerRadius))),
              tileColor: Colors.white,
              title: const Text('Username and Displayname'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DisplayNameSwitch(),
                  ),
                );
              },
            ),
            const Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Displayname'),
                  Text(
                    userInfo.displayName,
                    style: const TextStyle(color: Colors.black26),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DisplayNameSwitch(),
                  ),
                );
              },
            ),
            const Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('E-Mail'),
                  Text(
                    userInfo.authentication.email ?? "none@none.com",
                    style: TextStyle(color: Colors.black26),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EmailSwitch(),
                  ),
                );
              },
            ),
            const Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Password'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordSwitch(),
                  ),
                );
              },
            ),
            const Divider(height: 0),
            ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppStyle.cornerRadius),
                      bottomRight: Radius.circular(AppStyle.cornerRadius))),
              tileColor: Colors.white,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Privacy'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacySettingPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _appSettings(BuildContext context) {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 8, left: 15, bottom: 4),
        child: Text(
          "App",
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(51, 241, 241, 241),
          ),
          borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
        ),
        child: Column(children: [
          ListTile(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppStyle.cornerRadius),
                    topRight: Radius.circular(AppStyle.cornerRadius))),
            tileColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Language'),
                // Abstand zwischen Avatar und Text

                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.black12),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'English',
                    style: TextStyle(color: Colors.black12),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          const ListTile(
            tileColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Map'),
              ],
            ),
          ),
          const Divider(height: 0),
          const ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppStyle.cornerRadius),
                    bottomRight: Radius.circular(AppStyle.cornerRadius))),
            tileColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Farbe'),
              ],
            ),
          ),
        ]),
      )
    ];
  }

  List<Widget> _legalSettings(BuildContext context) {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 8, left: 15, bottom: 4),
        child: Text(
          "Rechtliche",
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(51, 241, 241, 241),
          ),
          borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
        ),
        child: const Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppStyle.cornerRadius),
                      topLeft: Radius.circular(AppStyle.cornerRadius))),
              tileColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('data protection'),
                ],
              ),
            ),
            Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('AGB'),
                ],
              ),
            ),
            Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Impressum'),
                ],
              ),
            ),
            Divider(height: 0),
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
              icon: const Icon(Icons.keyboard_backspace),
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
  ScaffoldMessenger.of(context).showSnackBar(
    messageSnackBar('Logged out!'),
  );
}
