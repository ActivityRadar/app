import 'package:app/app_state.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/community.dart';
import 'package:app/screens/home_Screen.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/start.dart';
import 'package:app/screens/map.dart';
import 'package:app/screens/settings.dart';

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
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final List<Widget> screens = [
    const HomePage(),
    const MapScreen(),
    const CommunityScreen(),
    const SettingScreen(),
  ];

  PageController pageController = PageController();

  int currentTab = 0;
  late Widget currentScreen;

  void onTap(int index) {
    if (currentTab != index) {
      pageController.jumpToPage(index);
      currentScreen = screens[index];
      setState(() {
        currentTab = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final state = Provider.of<AppState>(context, listen: false);
    SessionManager.instance.isLoggedIn().then((loggedIn) async {
      await SessionManager.instance.startSession();
      state.loadFromStorage();
    });

    currentScreen = screens[0];
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
      body: PageView(
        controller: pageController,
        onPageChanged: onTap,
        children: screens,
      ),
      floatingActionButton: showFAB
          ? FloatingActionButton(
              backgroundColor: DesignColors.naviColor,
              onPressed: () {
                bottomSheetAdd(context);
              },
              child: const Icon(AppIcons.add),
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
                        onTap(0);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NaviIcon(
                            icon: AppIcons.home, currentTab: currentTab == 0),
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
                        onTap(1);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NaviIcon(
                            icon: AppIcons.mapSharp,
                            currentTab: currentTab == 1),
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
                        onTap(2);
                      });
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NaviIcon(
                              icon: AppIcons.group,
                              currentTab: currentTab == 2),
                          NaviText(
                              text: 'Community', currentTab: currentTab == 2),
                        ]),
                  ),
                  MaterialButton(
                    minWidth: x,
                    onPressed: () {
                      setState(() {
                        onTap(3);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NaviIcon(
                            icon: AppIcons.settings,
                            currentTab: currentTab == 3),
                        NaviText(text: "Setting", currentTab: currentTab == 3),
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
