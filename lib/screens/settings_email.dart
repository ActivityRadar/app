import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:app/widgets/custom_button.dart';
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
              ScaffoldMessenger.of(context).showSnackBar(
                messageSnackBar('Cancel'),
              );
            },
            text: 'Cancel'),
        actions: [
          CustomTextButtonWhite(
              onPressed: () {
                if (formEmailKey.currentState!.validate()) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    messageSnackBar('Please fill input'),
                  );
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
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      labelText: "email"),
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
                  child: Text(
                    "Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin",
                    style: TextStyle(color: Colors.black12),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
