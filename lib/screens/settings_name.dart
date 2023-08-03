import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';

class DisplayNameSwitch extends StatelessWidget {
  const DisplayNameSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final formDisplaynameKey = GlobalKey<FormState>();
    final formUsernameKey = GlobalKey<FormState>();
    TextEditingController displaynameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Cancel')));
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
                if (formDisplaynameKey.currentState!.validate()) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill input')),
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
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 4),
              child: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/locationPhotoPlaceholder.jpg'),
                radius: 50,
              ),
            ),
            Form(
              key: formUsernameKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: usernameController,
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
                          labelText: "Anzeigename",
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Username';
                          }
                          if (!RegExps.username.hasMatch(value)) {
                            return "Anzeigename is wrong";
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
            Form(
              key: formDisplaynameKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: displaynameController,
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
                          labelText: "Anzeigename",
                        ),
                        validator: (value) {
                          if (!RegExps.displayname.hasMatch(value!)) {
                            return "Anzeigename is wrong";
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
