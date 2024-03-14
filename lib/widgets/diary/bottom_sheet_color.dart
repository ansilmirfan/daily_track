// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
Widget bottomSheetColor({required void Function(int) OnTap,required BuildContext context}){
  return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: borderRadiusOnlyS,
          topRight: borderRadiusOnlyS,
        ),
      ),
      height: height / 3,
      width: width - 20,
      padding: paddingXS,
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: List.generate(
            bgColors.length,
            (index) => Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  OnTap(index);
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: width / 3 - 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: bgColors[index],
                    border: Border.all(),
                    borderRadius: borderradiusS,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
}


