import 'package:app/app_state.dart';
import 'package:app/screens/login.dart';
import 'package:app/widgets/custom/alertdialog.dart';

import 'package:app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void conditionalShowLoginReminder(
    {required BuildContext context, required VoidCallback loggedInCallback}) {
  if (Provider.of<AppState>(context, listen: false).isLoggedIn) {
    loggedInCallback();
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              title: 'Du bist momentan nicht angemeldet!',
              content: const SystemText(
                  text:
                      "Du musst angemeldet sein, um bestimmte Funktionalitäten der App nutzen zu können. Beispielsweise Fotos hinzuzufügen, Bewertungen abzugeben, andere Nutzer zu melden und viele mehr."),
              firstbuttonText: "Anmelden",
              firstonPress: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              secondbuttonText: 'Nein, danke!',
              secondonPress: () {
                Navigator.of(context).pop();
              });
        });
  }
}
