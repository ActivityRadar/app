import 'package:app/constants/constants.dart';
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
      appBar: AppBar(
        leading: CustomTextButton(
            onPressed: () {
              Navigator.pop(context);
              showMessageSnackBar(context, 'Cancel');
            },
            text: 'Cancel'),
        actions: [
          CustomTextButtonWhite(
              onPressed: () {
                if (formPasswordKey.currentState!.validate()) {
                  Navigator.pop(context);
                } else {
                  showMessageSnackBar(context, 'Please fill input');
                }
              },
              text: 'Finish'),
        ],
      ),
      body: Form(
        key: formPasswordKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: PasswordTextFormField(
                    controller: oldPasswordController,
                    labelText: "old Password",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: PasswordTextFormField(
                    controller: newPasswordController,
                    labelText: 'new Password',
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
                    labelText: "new Password",
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
    );
  }
}
