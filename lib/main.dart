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
        scaffoldBackgroundColor: DesignColors.kBackgroundColor,
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
