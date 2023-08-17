import 'package:app/app_state.dart';
import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_text.dart';
import 'package:app/widgets/custom/snackbar.dart';
import 'package:app/widgets/custom/button.dart';
import 'package:app/widgets/custom/textfield.dart';
import 'package:app/model/generated.dart';
import 'package:app/provider/backend.dart';
import 'package:app/provider/generated/users_provider.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  PageController pageController = PageController();
  final _formEmailKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();
  final _formUsernameKey = GlobalKey<FormState>();
  final _formCodeKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();
  TextEditingController verifyCodeController = TextEditingController();
  bool isLoading = false;

  String? newUserId;

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  void previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  bool validateStructure(String value) {
    // TODO: Password gener;
    return RegExps.password.hasMatch(value);
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          userNameForm(context),
          emailForm(context),
          passwordForm(context),
          ageForm(context),
          verifyForm(),
          avatarForm(context),
        ],
      ),
    );
  }

  Padding avatarForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CustomElevatedButton(
              onPressed: () async {
                await bottomSheetPhotoSourcePicker(
                        context: context,
                        mode: "profile-picture",
                        userId: newUserId)
                    .then((_) {
                  Provider.of<AppState>(context, listen: false)
                      .updateUserInfo();
                }).then((_) => Navigator.of(context).pop());
              },
              text: "Profile picture",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(children: [
                CustomTextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'skip',
                ),
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Next",
                )
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Form verifyForm() {
    return Form(
      key: _formCodeKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: CustomTextFormField(
                  controller: verifyCodeController,
                  labelText: "Verify Code",
                  validator: (v) {
                    return v.length == 8
                        ? null
                        : "The code must be 8 digits long!";
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    previousPage();
                  },
                  text: "Cancel",
                ),
                CustomElevatedButton(
                  onPressed: () async {
                    bool success = await UsersProvider.verifyNewUser(
                        data: VerifyUserInfo(
                            id: newUserId!,
                            verificationCode: verifyCodeController.text));
                    if (success) {
                      bool loginSuccess = await AuthService.login(
                          usernameController.text, passwordController.text);
                      if (loginSuccess) {
                        await Provider.of<AppState>(context, listen: false)
                            .updateUserInfo();
                        nextPage();
                      }
                    } else {
                      print("Verification failed!");
                    }
                  },
                  text: "Next",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding ageForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.width / 3,
              child: TextFormField(
                controller: dateInput,
                //editing controller of this TextField
                decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());
                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              )),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  previousPage();
                },
                text: "Previous",
              ),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        // TODO: show loading circle
                        setState(() {
                          isLoading = true;
                        });

                        final response = await UsersProvider.createUser(
                            data: UserApiIn(
                                username: usernameController.text,
                                displayName: usernameController.text,
                                email: emailController.text,
                                password: passwordController.text));
                        newUserId = response.id;

                        setState(() {
                          isLoading = false;
                        });
                        nextPage();
                      },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const CustomText(
                        text: "Next",
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Form passwordForm(BuildContext context) {
    return Form(
      key: _formPasswordKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: PasswordTextFormField(
                controller: passwordController,
                labelText: "Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Password';
                  }
                  if (passwordController.text !=
                      passwordRepeatController.text) {
                    return 'Password is not the same ';
                  }
                  if (validateStructure(passwordController.text)) {
                  } else {
                    return 'Password rules units';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: PasswordTextFormField(
                controller: passwordRepeatController,
                labelText: "Password",
                validator: (secondvalue) {
                  if (secondvalue == null || secondvalue.isEmpty) {
                    return 'Please enter your Email';
                  }
                  if (passwordController.text != secondvalue) {
                    return 'Password is not the same';
                  }
                  if (validateStructure(passwordRepeatController.text)) {
                  } else {
                    return 'Password rules units';
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    previousPage();
                  },
                  text: "Previous",
                ),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formPasswordKey.currentState!.validate()) {
                      nextPage();
                    } else {
                      showMessageSnackBar(context, 'Please fill input');
                    }
                  },
                  text: "Next",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Form emailForm(BuildContext context) {
    bool? emailTaken;
    return Form(
      key: _formEmailKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: EmailTextFormField(
                controller: emailController,
                labelText: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  }
                  if (!RegExps.email.hasMatch(value)) {
                    return "Email is wrong";
                  }
                  if (emailTaken!) {
                    return "Email is already used by another account!";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                child: CustomElevatedButton(
                  onPressed: () async {
                    // have to check outside of the validator because of async call
                    emailTaken = await UsersProvider.checkEmailTaken(
                        email: emailController.text);
                    if (_formEmailKey.currentState!.validate()) {
                      nextPage();
                    } else {
                      showMessageSnackBar(context, 'Please fill input');
                    }
                  },
                  text: "Submit",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form userNameForm(BuildContext context) {
    bool? usernameTaken;
    return Form(
      key: _formUsernameKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: UsernameTextFormField(
                controller: usernameController,
                labelText: "Username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Username';
                  }
                  if (!RegExps.username.hasMatch(value)) {
                    return "Username is wrong";
                  }
                  if (usernameTaken!) {
                    return "Username is already taken!";
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      onPressed: () {
                        previousPage();
                      },
                      text: "Previous",
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        // have to check outside of the validator because of async call
                        usernameTaken = await UsersProvider.findUsersByName(
                                search: usernameController.text)
                            .then((userList) {
                          return userList.any((user) =>
                              user.username == usernameController.text);
                        });
                        if (_formUsernameKey.currentState!.validate()) {
                          nextPage();
                        } else {
                          showMessageSnackBar(context, 'Please fill input');
                        }
                      },
                      text: "Next",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
