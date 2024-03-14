import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/intro_screens/onboard_screens/main_onboard.dart';
import 'package:diary_app/screens/intro_screens/password.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/logo.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// ignore: camel_case_types
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    password = settingsDb.get('password');
    profilepicture = settingsDb.get('profilepicture');
    userName = settingsDb.get('username');
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
      splash: logo(),
      animationDuration: const Duration(seconds: 3),
      splashIconSize: height / 4,
      backgroundColor: primaryCream,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: check_alredyloggedin() ? const Password() : const OnBoard(),
    );
  }

  // ignore: non_constant_identifier_names
  bool check_alredyloggedin() {
    if (password != null) {
      return true;
    } else {
      return false;
    }
  }
}
