import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
Widget draggableBottomSheet({required void Function(int) updateSelectedIndex}){
  return DraggableScrollableSheet(
      maxChildSize: 1.0,
      minChildSize: 0.5,
      initialChildSize: 0.5,
      builder: (context, scrollController) => Padding(
        padding: paddingXS,
        child: Container(
          decoration: const BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.only(
                topLeft: borderRadiusOnlyS, topRight: borderRadiusOnlyS),
          ),
          child: Padding(
            padding: paddingS,
            child: ListView.builder(
              controller: scrollController,
              itemCount: fonts.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    updateSelectedIndex(index);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: paddingXS,
                    decoration: BoxDecoration(
                      borderRadius: borderradiusS,
                      border: Border.all(),
                    ),
                    child: Text(
                      userName,
                      style: fonts[index](18.0, primaryBlack),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
}

