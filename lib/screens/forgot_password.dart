import 'package:app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailControllersecond = TextEditingController();

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
                    Text("Forget your Password"),
                    // User/Email Input
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username/Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username/Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    // Second Email Input

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: emailControllersecond,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username/Email"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username/Email';
                          }
                          return null;
                        },
                      ),
                    ),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')),
                              );
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
