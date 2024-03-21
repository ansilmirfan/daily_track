import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/intro_screens/password.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/logo.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:diary_app/widgets/common/textbutton.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class CreatePassword extends StatefulWidget {
  bool alreadyLoggedIn;
  // ignore: use_key_in_widget_constructors
  CreatePassword({this.alreadyLoggedIn = false});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

TextEditingController password1 = TextEditingController();
TextEditingController password2 = TextEditingController();
bool obscureText1 = true;
bool obscureText2 = true;

// ignore: camel_case_types
class _CreatePasswordState extends State<CreatePassword> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: primaryCream,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: key2,
              child: Column(
                children: [
                  logo(),
                  SizedBox(
                    height: height / 20,
                  ),
                  inputField(
                    horizontal_padding: 20.0,
                    controller: password1,
                    borderwidth: 2.0,
                    labeltext: 'Password',
                    hinttext: 'Enter password',
                    hintcolor: Colors.grey,
                    obscuretext: obscureText2,
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText2 = !obscureText2;
                          });
                        },
                        icon: obscureText2
                            ? const Icon(
                                Icons.visibility,
                                color: primaryBlack,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: primaryBlack,
                              )),
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty. Please enter a password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  inputField(
                    horizontal_padding: 20.0,
                    controller: password2,
                    borderwidth: 2.0,
                    labeltext: 'Confirm New Password',
                    hinttext: 'enter password',
                    hintcolor: Colors.grey,
                    obscuretext: obscureText1,
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText1 = !obscureText1;
                          });
                        },
                        icon: obscureText1
                            ? const Icon(
                                Icons.visibility,
                                color: primaryBlack,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: primaryBlack,
                              )),
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re enter password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  textButtonWidget(
                    function: () {
                      if (key2.currentState!.validate()) {
                        if (password1.text == password2.text) {
                          if (password1.text == password ||
                              password2.text == password) {
                            snackbarMessage(
                                context,
                                'Sorry! you entered the old password please enter new password ',
                                'warning');
                          } else if (widget.alreadyLoggedIn) {
                            Navigator.of(context).pop();
                            password = password1.text;
                            settingsDb.put('password', '$password');

                            snackbarMessage(context,
                                'password updated successfully!', 'success');
                          } else {
                            snackbarMessage(context,
                                'password updated successfully!', 'success');
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Password(),
                              ),
                            );
                            password = password1.text;
                            settingsDb.put('password', '$password');
                          }
                        } else {
                          snackbarMessage(
                              context,
                              'Passwords do not match. Please make sure both passwords are the same',
                              'error');
                        }
                      }
                    },
                    text: 'Save password',
                    width: width * 9 / 10,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
