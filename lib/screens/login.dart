import 'package:app/provider/backend.dart';
import 'package:app/screens/foregetpassword.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
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
                        controller: emailController,
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
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Navigate the user to the Home page
                              print(emailController.text);
                              print(passwordController.text);
                              if (await AuthService.login(emailController.text,
                                  passwordController.text)) {
                                print("Login successful!");
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')),
                              );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}
