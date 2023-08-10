import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_snackbar.dart';
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
        leading: TextButton(
          style: TextButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              messageSnackBar('Cancel'),
            );
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (formPasswordKey.currentState!.validate()) {
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  messageSnackBar('Please fill input'),
                );
              }
            },
            child: const Text(
              'Finish',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
                child: TextFormField(
                  obscureText: true,
                  controller: oldPasswordController,
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
                      labelText: "old Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old Password';
                    }
                    if (!RegExps.username.hasMatch(value)) {
                      return "Password is wrong";
                    }

                    return null;
                  },
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin Moin",
                    style: TextStyle(color: Colors.black12),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: true,
                  controller: newPasswordController,
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
                      labelText: "new Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new Password';
                    }
                    if (!RegExps.username.hasMatch(value)) {
                      return "Password is wrong";
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  obscureText: true,
                  controller: newPasswordRepeatController,
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
                      labelText: "new Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new Password';
                    }
                    if (!RegExps.username.hasMatch(value)) {
                      return "Password is wrong";
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
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
