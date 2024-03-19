// ignore_for_file: must_be_immutable

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class stx extends StatelessWidget {
  Function(int index) ontap;
  stx({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (BuildContext context, ScrollController scrollController) =>
          Padding(
        padding: paddingXS,
        child: ListView.builder(
          controller: controller,
          itemCount: fonts.length,
          itemBuilder: (context, index) => Padding(
            padding: paddingXS,
            child: GestureDetector(
              onTap: () => ontap(index),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: borderradiusS,
                  border: Border.all(),
                ),
                child: Text(
                  userName,
                  style: fonts[index](20.0, primaryBlack),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

ScrollController controller = ScrollController();
textStyleBottomSheet(
    {required BuildContext ctx, required Function(int index) ontap}) {
  return DraggableScrollableSheet(
    builder: (BuildContext context, ScrollController scrollController) =>
        Padding(
      padding: paddingXS,
      child: ListView.builder(
        controller: controller,
        itemCount: fonts.length,
        itemBuilder: (context, index) => Padding(
          padding: paddingXS,
          child: GestureDetector(
            onTap: () => ontap(index),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              height: 35,
              decoration: BoxDecoration(
                borderRadius: borderradiusS,
                border: Border.all(),
              ),
              child: Text(
                userName,
                style: fonts[index](20.0, primaryBlack),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
