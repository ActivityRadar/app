import 'package:app/provider/backend.dart';
import 'package:app/screens/foregetpassword.dart';
import 'package:app/screens/login.dart';
import 'package:app/screens/toregister.dart';
import 'package:flutter/material.dart';

class LoginandRegisterScreen extends StatefulWidget {
  const LoginandRegisterScreen({Key? key}) : super(key: key);

  @override
  State<LoginandRegisterScreen> createState() => _LoginandRegisterScreen();
}

class _LoginandRegisterScreen extends State<LoginandRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonBar(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ToRegisterScreen(),
                    ),
                  );
                },
                child: const Text('Registieren'),
              ),
            ]),
          ]),
    );
  }
}
