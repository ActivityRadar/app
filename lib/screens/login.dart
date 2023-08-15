import 'package:app/app_state.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/forgot_password.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_textfield.dart';
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
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Login"),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: CustomTextFormField(
                          controller: usernameController,
                          labelText: "Username",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: CustomTextFormField(
                          controller: passwordController,
                          labelText: "Password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
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
                          text: 'Forget password'),
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
                          text: "Submit",
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}

void handleLogin(BuildContext context, String username, String password,
    GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate()) {
    // Navigate the user to the Home page
    AuthService.login(username, password).then((success) {
      if (success) {
        Provider.of<AppState>(context, listen: false).updateUserInfo();

        showMessengeSnackBar(context, 'Login successful!');

        Navigator.of(context).pop();
      } else {
        showMessengeSnackBar(context, 'Login failed!');
      }
    });
  } else {
    showMessengeSnackBar(context, 'Please fill input!');
  }
}
