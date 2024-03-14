// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:flutter/material.dart';
Widget floatingButton({ required Function()? onpressed}){
  return FloatingActionButton(
      backgroundColor: primaryYellow,
      splashColor: primaryRed,
      shape: const CircleBorder(),
      onPressed: onpressed,
      child: const Icon(Icons.add),
    );
}


