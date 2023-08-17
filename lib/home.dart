import 'package:app/app_state.dart';
import 'package:app/screens/community.dart';
import 'package:app/screens/start.dart';
import 'package:app/screens/map.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/widgets_page.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:app/widgets/custom/icon.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app/constants/design.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const SettingScreen(),
    const MapScreen(),
    const CommunityScreen()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Provider.of<AppState>(context, listen: false).loadFromStorage();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      Provider.of<AppState>(context, listen: false).saveToStorage();
    }
  }

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
                        NaviIcon(icon: Icons.home, currentTab: currentTab == 0),
                        NaviText(
                            text: AppLocalizations.of(context)!.home,
                            currentTab: currentTab == 0)
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
                        NaviIcon(
                            icon: Icons.map_sharp, currentTab: currentTab == 1),
                        NaviText(
                            text: AppLocalizations.of(context)!.map,
                            currentTab: currentTab == 1),
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
                          NaviIcon(
                              icon: Icons.group, currentTab: currentTab == 3),
                          NaviText(
                              text: 'Community', currentTab: currentTab == 3),
                        ]),
                  ),
                  MaterialButton(
                    minWidth: x,
                    onPressed: () {
                      setState(() {
                        currentScreen = const SettingScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NaviIcon(
                            icon: Icons.settings, currentTab: currentTab == 4),
                        NaviText(text: "Setting", currentTab: currentTab == 4),
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
