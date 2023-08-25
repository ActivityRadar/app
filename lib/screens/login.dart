import 'package:app/app_state.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/forgot_password.dart';
import 'package:app/widgets/custom/appbar.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore_for_file: avoid_print
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: CustomAppBar(
          context,
          () {
            Navigator.pop(context);
          },
        ),
        body: BackgroundSVG(
          children: Form(
              key: _formKey,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PageTitleText(
                          text: "Login",
                          width: width,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 16),
                            child: UsernameTextFormField(
                              controller: usernameController,
                              label: "Nutzername",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Gib einen Nutzernamen an!';
                                }
                                return null;
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: PasswordTextFormField(
                              controller: passwordController,
                              label: "Passwort",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Gib dein Passwort ein!';
                                }
                                return null;
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1.0),
                          child: CustomTextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              text: 'Passwort vergessen'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16.0),
                          child: Center(
                            child: CustomElevatedButton(
                              onPressed: () {
                                handleLogin(context, usernameController.text,
                                    passwordController.text, _formKey);
                              },
                              text: "Abschicken",
                            ),
                          ),
                        ),
                      ]))),
        ));
  }
}

void handleLogin(BuildContext context, String username, String password,
    GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    // Navigate the user to the Home page
    AuthService.login(username, password).then((success) {
      if (success) {
        Provider.of<AppState>(context, listen: false).updateUserInfo();

        SessionManager.instance.startSession();

        showMessageSnackBar(context, 'Erfolgreich eingeloggt!');

        Navigator.of(context).pop();
      } else {
        showMessageSnackBar(context, 'Login fehlgeschlagen!');
      }
    });
  } else {
    showMessageSnackBar(context, 'Bitte Eingabe füllen!');
  }
}
