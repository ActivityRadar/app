import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/textfield.dart';

import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailRepeatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SystemText(text: "Forget your Password"),
                    // User/Email Input
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: EmailTextFormField(
                          controller: emailController,
                          label: "Username/Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username/Email';
                            }
                            return null;
                          },
                        )),
                    // Second Email Input

                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: EmailTextFormField(
                          controller: emailRepeatController,
                          label: "Username/Email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username/Email';
                            }
                            return null;
                          },
                        )),
                    // Second Email Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: CustomElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Navigate the user to the Home page
                              print(emailController.text);
                            } else {
                              showMessageSnackBar(context, 'Please fill input');
                            }
                          },
                          text: "Submit",
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}
