// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, prefer_const_constructors_in_immutables

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
Widget textButtonWidget({required  final Function() function,required final text,final width=120.0, final height=55.0}){
  return ElevatedButton(
      onPressed: function,
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll(primaryRed),
        minimumSize: MaterialStatePropertyAll(
          Size(width, height),
        ),
        shape: const MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: borderradiusS,
          ),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.karantina(color: primaryWhite, fontSize: 25),
      ),
    );
}

