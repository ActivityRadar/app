import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:app/widgets/photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  TextEditingController verifyCode = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  void previousPage() {
    pageController.animateToPage(pageController.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  bool validateStructure(String value) {
    // TODO: Password gener;
    return RegExps.password.hasMatch(value);
  }

  void nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          //Email Form
          Form(
            key: _formEmailKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        if (!RegExps.email.hasMatch(value)) {
                          return "Email is wrong";
                        }

                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formEmailKey.currentState!.validate()) {
                            nextPage();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              messageSnackBar('Please fill input'),
                            );
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Password Form
          Form(
            key: _formPasswordKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordRepeatController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
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
                      ElevatedButton(
                        onPressed: () {
                          previousPage();
                        },
                        child: const Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formPasswordKey.currentState!.validate()) {
                            nextPage();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              messageSnackBar('Please fill input'),
                            );
                          }
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Username Form
          Form(
            key: _formUsernameKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
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
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              previousPage();
                            },
                            child: const Text('Previous'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formUsernameKey.currentState!.validate()) {
                                nextPage();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  messageSnackBar('Please fill input'),
                                );
                              }
                            },
                            child: const Text('Next'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // birthday
          Padding(
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
                    ElevatedButton(
                      onPressed: () {
                        previousPage();
                      },
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        nextPage();
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Verfiy Code
          Form(
            key: _formCodeKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: verifyCode,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Verify Code"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          previousPage();
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          nextPage();
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Profil Photo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: () => bottomSheetPhotoSourcePicker(
                        context: context, mode: "profil", userId: "TODO"),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(100),
                      backgroundColor: Colors.blue, // <-- Button color
                      foregroundColor: const Color.fromARGB(
                          255, 255, 255, 255), // <-- Splash color
                    ), //TODO userID,
                    child: const Text("Profile picture"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('skip'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Next'),
                      )
                    ]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
