import 'package:app/app_state.dart';
import 'package:app/provider/backend.dart';
import 'package:app/screens/forgot_password.dart';
import 'package:app/widgets/customsnackbar.dart';
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
                      child: TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        controller: usernameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text('Forget password'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16.0),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            handleLogin(context, usernameController.text,
                                passwordController.text, _formKey);
                          },
                          child: const Text('Submit'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          messageSnackBar('Login successful!'),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          messageSnackBar('Login failed!'),
        );
      }
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      messageSnackBar('Please fill input!'),
    );
  }
}
