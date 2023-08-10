import 'package:app/screens/community.dart';
import 'package:app/screens/start.dart';
import 'package:app/screens/map.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/widgets_page.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/constants/constants.dart';
import 'package:app/constants/design.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    SettingScreen(),
    const MapScreen(),
    const CommunityScreen()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    //size of the window
    var size = MediaQuery.of(context).size;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    final showFAB = !(isKeyboardVisible || currentScreen is SettingScreen);
    var height = size.height;
    var width = size.width;
    var x = width / 4.5;
    return Scaffold(
      extendBody: true,
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: showFAB
          ? FloatingActionButton(
              backgroundColor: DesignColors.naviColor,
              onPressed: () {
                bottomSheetAdd(context);
              },
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: height / 15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: x,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home,
                            color: currentTab == 0
                                ? DesignColors.naviColor
                                : Colors.grey),
                        Text(
                          AppLocalizations.of(context)!.home,
                          style: TextStyle(
                              color: currentTab == 0
                                  ? DesignColors.naviColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: x,
                    onPressed: () {
                      setState(() {
                        currentScreen = const MapScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_sharp,
                            color: currentTab == 1
                                ? DesignColors.naviColor
                                : Colors.grey),
                        Text(
                          AppLocalizations.of(context)!.map,
                          style: TextStyle(
                              color: currentTab == 1
                                  ? DesignColors.naviColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: x,
                    onPressed: () {
                      setState(() {
                        currentScreen = const TestWidget();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group,
                            color: currentTab == 3
                                ? DesignColors.naviColor
                                : Colors.grey),
                        Text(
                          'Community',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? DesignColors.naviColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: x,
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings,
                            color: currentTab == 4
                                ? DesignColors.naviColor
                                : Colors.grey),
                        Text(
                          'Setting',
                          style: TextStyle(
                              color: currentTab == 4
                                  ? DesignColors.naviColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
