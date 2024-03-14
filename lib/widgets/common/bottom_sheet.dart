// ignore_for_file: non_constant_identifier_names

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';

showBottomsheet({
  required BuildContext context,
  required Widget content,
  bool isScrollControlled = false,
  double height = 200,
}) {
  return showModalBottomSheet(
    isScrollControlled: isScrollControlled,
    context: context,
    builder: (context) {
      return Padding(
        padding: paddingXS,
        child: Container(
          padding: paddingXS,
          decoration: const BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.only(
              topLeft: borderRadiusOnlyS,
              topRight: borderRadiusOnlyS,
            ),
          ),
          height: isScrollControlled ? null : height,
          child: content,
        ),
      );
    },
  );
}
