import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';

snackbarMessage(BuildContext context, String message, String type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(15),
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Padding(
        padding: EdgeInsets.only(bottom: height / 15),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: width,
          color: bgColor(type),
          child: Wrap(
            children: [
              leadingIcon(type),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

Color bgColor(String type) {
  Color color = primaryRed;
  switch (type) {
    case 'warning':
      color = primaryYellow;
      break;
    case 'success':
      color = const Color.fromARGB(255, 68, 175, 165);
      break;
    case 'error':
      color = const Color.fromARGB(255, 211, 74, 64);
      break;
    default:
      break;
  }
  return color;
}

Widget leadingIcon(String type) {
  Widget? icon;
  switch (type) {
    case 'warning':
      icon = const Icon(
        Icons.warning,
        color: primaryWhite,
      );
      break;
    case 'success':
      icon = const Icon(
        Icons.check,
        color: primaryWhite,
      );
      break;

    case 'error':
      icon = const Icon(
        Icons.error_rounded,
        color: primaryWhite,
      );
      break;
  }
  return icon!;
}
