// ignore_for_file: file_names

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/intro_screens/user_details.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/logo.dart';
import 'package:diary_app/widgets/common/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

// ignore: camel_case_types
class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryCream,
      body: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: height / 8,
                ),
                logo(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome to\nDaily  Trac',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Track your days,\nshape your destiny',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kaushanScript(
                      color: primaryBlack, fontSize: 35),
                ),
              ],
            ),
            textButtonWidget(
              function: () {
                navigatePushReplacement(
                  context,
                  UserDetails(),
                );
              },
              text: 'Get started',
              width: width * 6 / 8,
            ),
          ],
        ),
      ),
    );
  }
}
