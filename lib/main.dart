import 'package:app/app_state.dart';
import 'package:app/provider/activity_type.dart';
import 'package:flutter/material.dart';
import 'package:app/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:app/constants/design.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ActivityManager.instance.init();
  await FlutterMapTileCaching.initialise();
  await FMTC.instance('mapStore').manage.createAsync();

  runApp(ChangeNotifierProvider(
      create: (context) => AppState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Fira Sans",
        //  scaffoldBackgroundColor: Color.fromARGB(255, 162, 189, 253),
        scaffoldBackgroundColor: DesignColors.kBackground,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: DesignColors.kBackground,
        ),
        primaryColor: const Color.fromARGB(255, 204, 68, 53),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all(DesignColors.grey),
          overlayColor: MaterialStateProperty.all(DesignColors.green),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: DesignColors.kBackground,
          labelStyle: CustomTextStyle.label,
          border: AppInputBorders.none,
          focusedErrorBorder: AppInputBorders.none,
          errorBorder: AppInputBorders.none,
          enabledBorder: AppInputBorders.none,
          focusedBorder: AppInputBorders.none,
        ),
        timePickerTheme: TimePickerThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          backgroundColor: DesignColors.naviColor,
          behavior: SnackBarBehavior.floating,
          elevation: 6.0,
        ),
        sliderTheme: const SliderThemeData(
          valueIndicatorTextStyle: TextStyle(color: DesignColors.blue),
        ),
        iconTheme: const IconThemeData(),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(51, 241, 241, 241),
            ),
            borderRadius: BorderRadius.circular(AppStyle.cornerRadius),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: DesignColors.naviColor,
          labelStyle: TextStyle(color: DesignColors.kBackground, fontSize: 10),
        ),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: DesignColors.blue,
            onPrimary: DesignColors.kBackground,
            secondary: DesignColors.green,
            onSecondary: DesignColors.kBackground,
            error: DesignColors.red,
            onError: DesignColors.red,
            background: DesignColors.kBackground,
            onBackground: DesignColors.kBackground,
            surface: DesignColors.kBackground,
            onSurface: DesignColors.grey),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: const Home(),
    );
  }
}
