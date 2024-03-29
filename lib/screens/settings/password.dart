import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom/appbar.dart';
import 'package:app/widgets/custom/background.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:flutter/material.dart';

class PasswordSwitch extends StatelessWidget {
  const PasswordSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final formPasswordKey = GlobalKey<FormState>();

    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController newPasswordRepeatController = TextEditingController();

    return Scaffold(
        appBar: CustomWithActionAppBar(
          context,
          () {
            Navigator.pop(context);
            showMessageSnackBar(context, 'Cancel');
          },
          () {
            if (formPasswordKey.currentState!.validate()) {
              Navigator.pop(context);
            } else {
              showMessageSnackBar(context, 'Please fill input');
            }
          },
        ),
        body: BackgroundSVG(
          children: Form(
            key: formPasswordKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: PasswordTextFormField(
                        controller: oldPasswordController,
                        label: "old Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your old Password';
                          }
                          if (!RegExps.username.hasMatch(value)) {
                            return "Password is wrong";
                          }

                          return null;
                        },
                      )),
                  const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: InfoText(
                        text: "Moin Moin Moin Moin Moin Moin Moin Moin ",
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: PasswordTextFormField(
                        controller: newPasswordController,
                        label: 'new Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new Password';
                          }
                          if (!RegExps.username.hasMatch(value)) {
                            return "Password is wrong";
                          }
                          return null;
                        },
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: PasswordTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new Password';
                          }
                          if (!RegExps.username.hasMatch(value)) {
                            return "Password is wrong";
                          }

                          return null;
                        },
                        label: "new Password",
                        controller: newPasswordRepeatController),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: InfoText(
                        text:
                            "Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin",
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
