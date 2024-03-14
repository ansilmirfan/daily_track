// ignore_for_file: must_be_immutable

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Pages extends StatelessWidget {
  String lottieAsset;
  String captionText;
  Pages({super.key, required this.captionText, required this.lottieAsset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 3 / 4,
      child: Padding(
        padding: paddingXS,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: height * 4 / 10,
              child: Lottie.asset(lottieAsset),
            ),
            Text(
              captionText,
              style: fonts[17](18.0, primaryBlack),
            )
          ],
        ),
      ),
    );
  }
}
