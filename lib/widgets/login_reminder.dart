import 'package:app/app_state.dart';
import 'package:app/screens/login.dart';
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
          return AlertDialog(
            title: const Text("You are not logged in!"),
            content: const Text(
                "You must be logged into a user account to use certain functionalities of the app like: Adding photos, reviews, locations, and many more."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text("Sign in / Register")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No, thanks!"))
            ],
          );
        });
  }
}
