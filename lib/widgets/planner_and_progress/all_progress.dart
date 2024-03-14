// ignore_for_file: must_be_immutable

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';

Widget allCircularProgress({required int doneCount, required int totalCount}) {
  int percentage = 0;

  if (totalCount != 0) {
    double result = doneCount / totalCount * 100;
    if (result.isFinite) {
      percentage = result.toInt();
    }
  }
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: height / 10,
        width: height / 10,
        child: CircularProgressIndicator(
          color: primaryBlack,
          backgroundColor: grey,
          strokeWidth: 15,
          value: totalCount != 0 ? doneCount / totalCount : 0,
        ),
      ),
      Text('$percentage%')
    ],
  );
}
