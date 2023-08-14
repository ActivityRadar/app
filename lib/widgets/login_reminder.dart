import 'package:app/app_state.dart';
import 'package:app/screens/login.dart';
import 'package:app/widgets/custom_alertdialog.dart';
import 'package:app/widgets/custom_button.dart';
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
              title: 'You are not logged in!',
              content: Text(
                  "You must be logged into a user account to use certain functionalities of the app like: Adding photos, reviews, locations, and many more."),
              firstbuttonText: "Sign in / Register",
              firstonPress: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              secondbuttonText: 'No, thanks!',
              secondonPress: () {
                Navigator.of(context).pop();
              });
        });
  }
}
