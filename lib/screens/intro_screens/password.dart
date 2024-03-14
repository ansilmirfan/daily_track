import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/bottom_navigation.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/logo.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:diary_app/widgets/common/textbutton.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});
  @override
  State<Password> createState() => _PasswordState();
}

TextEditingController controller = TextEditingController();
bool obscureText = true;

class _PasswordState extends State<Password> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: primaryCream,
        body: Align(
          child: SingleChildScrollView(
            child: Column(
              children: [
                logo(),
                SizedBox(
                  height: height / 20,
                ),
                inputField(
                  controller: controller,
                  horizontal_padding: 20,
                  borderwidth: 2,
                  hinttext: 'Enter password',
                  hintcolor: Colors.grey,
                  labeltext: 'Password',
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
                          ),
                  ),
                ),
                SizedBox(
                  height: height / 20,
                ),
                textButtonWidget(
                  function: () {
                    if (controller.text == password) {
                      navigatePushReplacement(context, const BottomNav());
                    } else {
                      snackbarMessage(context, 'Wrong password');
                    }
                  },
                  text: 'Submit',
                  width: width * 9 / 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
