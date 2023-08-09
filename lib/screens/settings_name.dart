import 'package:app/app_state.dart';
import 'package:app/constants/constants.dart';
import 'package:app/provider/generated/users_provider.dart';
import 'package:app/provider/photos.dart';
import 'package:app/widgets/bottomsheet.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:app/widgets/customsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayNameSwitch extends StatelessWidget {
  const DisplayNameSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final formDisplaynameKey = GlobalKey<FormState>();
    final formUsernameKey = GlobalKey<FormState>();

    final state = Provider.of<AppState>(context);

    TextEditingController usernameController =
        TextEditingController(text: state.currentUser!.username);
    TextEditingController displaynameController =
        TextEditingController(text: state.currentUser!.displayName);

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
              onPressed: () async {
                final Map<String, dynamic> data = {};
                var ok = true;
                if (formUsernameKey.currentState!.validate()) {
                  if (usernameController.text != state.currentUser!.username) {
                    data["username"] = usernameController.text;
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    messageSnackBar("Enter a valid username!"),
                  );
                  ok = false;
                  print("Invalid new username!");
                }
                if (formDisplaynameKey.currentState!.validate()) {
                  if (displaynameController.text !=
                      state.currentUser!.displayName) {
                    data["display_name"] = displaynameController.text;
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enter a valid displayName!')),
                  );
                  ok = false;
                  print("Invalid new display name!");
                }

                if (ok) {
                  if (data.isNotEmpty) {
                    await UsersProvider.updateUser(data: data)
                        .then((_) => state.updateUserInfo());
                  }
                  Navigator.pop(context);
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
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: GestureDetector(
                  onTap: () {
                    bottomSheetAvatarAction(context);
                  },
                  child: avatarFutureBuilder(
                    context: context,
                    radius: 50,
                  )),
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
                        keyboardType: TextInputType.visiblePassword,
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
                          labelText: "Nutzername",
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Username';
                          }
                          if (!RegExps.username.hasMatch(value)) {
                            return "Username is wrong";
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
                            return "Displayname is wrong";
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

Widget avatarFutureBuilder({
  required BuildContext context,
  required double radius,
}) {
  final state = Provider.of<AppState>(context, listen: false);

  if (state.currentUser!.avatar == null) {
    return CircleAvatar(
        backgroundImage: AssetImages.avatarEmpty,
        radius: radius);
  }

  final image = PhotoManager.instance.getPhoto(state.currentUser!.avatar!.url);
  return FutureBuilder(
      future: image,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var img;
        if (snapshot.hasData) {
          img = snapshot.data;
        } else {
          img = AssetImages.avatarLoading;
        }
        return CircleAvatar(backgroundImage: img, radius: radius);
      });
}

Future<void> bottomSheetAvatarAction(BuildContext context) async {
  final state = Provider.of<AppState>(context, listen: false);
  final currentAvatar = state.currentUser!.avatar;
  final userId = state.currentUser!.id;

  Future<void> updateAndReturn({bool returnAfter = true}) async {
    Future f = state.updateUserInfo();
    if (returnAfter) {
      f.then((_) => Navigator.of(context).pop());
    }
  }

  if (currentAvatar == null) {
    avatarPicker(context, userId)
        .then((_) => updateAndReturn(returnAfter: false));
  } else {
    bottomSheetBase(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete current photo"),
                onTap: () {
                  UsersProvider.deleteProfilePhoto()
                      .then((_) => updateAndReturn());
                  // TODO: do something to show the user that the photo is gone
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload),
                title: const Text("Set new photo"),
                onTap: () {
                  avatarPicker(context, userId).then((_) => updateAndReturn());
                },
              )
            ],
          );
        });
  }
}

Future<void> avatarPicker(BuildContext context, String userId) async {
  await bottomSheetPhotoSourcePicker(
      context: context,
      mode: "profile-picture",
      userId: userId,
      onUploadCallback: (url) {
        // TODO: display image in widget (make DisplayNameSwitch stateful
        // and give it a refresh function that is called here)
      });
}
