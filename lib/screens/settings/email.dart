import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:flutter/material.dart';

class EmailSwitch extends StatelessWidget {
  const EmailSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final formEmailKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: CustomTextButtonWhite(
            onPressed: () {
              Navigator.pop(context);
              showMessageSnackBar(context, 'Cancel');
            },
            text: 'Cancel'),
        actions: [
          CustomTextButtonWhite(
              onPressed: () {
                if (formEmailKey.currentState!.validate()) {
                  Navigator.pop(context);
                } else {
                  showMessageSnackBar(context, 'Please fill input');
                }
              },
              text: 'Finish'),
        ],
      ),
      body: Form(
        key: formEmailKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: EmailTextFormField(
                  controller: emailController,
                  label: "email",
                  validator: (value) {
                    if (value != null || value!.isEmpty) {
                      if (!RegExps.email.hasMatch(value)) {
                        return "Email is wrong";
                      }
                    }

                    return null;
                  },
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: InfoText(
                    text:
                        "Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin",
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
