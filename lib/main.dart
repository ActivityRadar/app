import 'package:app/app_state.dart';
import 'package:app/provider/activity_type.dart';
import 'package:flutter/material.dart';
import 'package:app/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:app/constants/design.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ActivityManager.instance.init();

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
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: DesignColors.kBackgroundColor,
        ),
        primaryColor: const Color.fromARGB(255, 204, 68, 53),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(DesignColors.redColor),
          trackColor: MaterialStateProperty.all(Colors.grey),
          overlayColor:
              MaterialStateProperty.all(Color.fromARGB(255, 210, 24, 24)),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: CustomTextStyle.label,
          border: AppInputBorders.none,
          focusedErrorBorder: AppInputBorders.none,
          errorBorder: AppInputBorders.none,
          enabledBorder: AppInputBorders.none,
          focusedBorder: AppInputBorders.none,
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
            valueIndicatorColor: DesignColors.greenColor,
            overlayColor: DesignColors.greenColor),
        iconTheme: const IconThemeData(),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: DesignColors.blueColor,
            onPrimary: DesignColors.kBackgroundColor,
            secondary: DesignColors.greenColor,
            onSecondary: DesignColors.kBackgroundColor,
            error: DesignColors.redColor,
            onError: DesignColors.redColor,
            background: DesignColors.kBackgroundColor,
            onBackground: DesignColors.kBackgroundColor,
            surface: DesignColors.kBackgroundColor,
            onSurface: DesignColors.kBackgroundColor),
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
