// ignore_for_file: camel_case_types

import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
Widget logo(){
  return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Image.asset(
        'Assets/image/logo.jpg',
        height: height / 4,
      ),
    );
}

