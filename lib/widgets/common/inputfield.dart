// ignore_for_file: camel_case_types, non_constant_identifier_names, unnecessary_null_in_if_null_operators

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:flutter/material.dart';

Widget inputField({
  final double horizontal_padding = 0.0,
  final Color? bgcolor,
  final Color bordercolor = primaryBlack,
  bool obscuretext = false,
  Widget? trailing,
  final Widget? leading,
  required TextEditingController controller,
  final Color? field_textcolor,
  final String? hinttext,
  final Color? hintcolor,
  final double borderwidth = 1.0,
  final String? labeltext,
  final Color? labelcolor,
  final Function(String)? onChanged,
  final String? Function(String? value)? validation,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal_padding,
    ),
    child: TextFormField(
      onChanged: onChanged,
      validator: validation,
      style: TextStyle(color: field_textcolor),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscuretext,
      obscuringCharacter: '*',
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        prefix: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: leading,
        ),
        suffixIcon: trailing,
        labelText: labeltext ?? null,
        labelStyle: TextStyle(color: labelcolor),
        fillColor: bgcolor,
        hintText: '$hinttext',
        hintStyle: TextStyle(color: hintcolor),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: bordercolor, width: borderwidth),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: bordercolor, width: borderwidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: bordercolor, width: borderwidth),
        ),
      ),
    ),
  );
}
