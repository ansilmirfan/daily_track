import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/intro_screens/create_password.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/logo.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:diary_app/widgets/common/textbutton.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class changePassword extends StatefulWidget {
  bool alreadyloggein;
  // ignore: use_key_in_widget_constructors
  changePassword({this.alreadyloggein = false});

  @override
  State<changePassword> createState() => _changePasswordState();
}

TextEditingController controller = TextEditingController();
bool obscureText = true;

// ignore: camel_case_types
class _changePasswordState extends State<changePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryCream,
      body: Align(
        child: SingleChildScrollView(
          child: Column(
            children: [
              logo(),
              const SizedBox(
                height: 20,
              ),
              inputField(
                controller: controller,
                horizontal_padding: 10.0,
                borderwidth: 2,
                hinttext: 'Enter current password',
                hintcolor: Colors.grey,
                labeltext: 'Enter your password',
                obscuretext: obscureText,
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: obscureText
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
                    return '! enter password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              textButtonWidget(
                function: () {
                  if (controller.text == password) {
                    navigatePushReplacement(context,
                        CreatePassword(alreadyLoggedIn: widget.alreadyloggein));
                  } else {
                    snackbarMessage(context, '! Wrong password', 'error');
                  }
                },
                text: 'Next',
                width: width * 9 / 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
