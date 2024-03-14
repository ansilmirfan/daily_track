import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:flutter/material.dart';
Widget linearProgress({required int doneCount,required int totalCount,required String category }){
    int percentage = 0;

    if (totalCount != 0) {
      double result = doneCount / totalCount * 100;
      if (result.isFinite) {
        percentage = result.toInt();
      }
    }
    return Wrap(
      runSpacing: 5,
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(category),
        ),
        LinearProgressIndicator(
          minHeight: 10,
          backgroundColor: grey,
          valueColor: AlwaysStoppedAnimation(
            categoryColor(category),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          value: totalCount != 0 ? (doneCount / totalCount) : 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$doneCount/$totalCount'),
            Text('$percentage%'),
          ],
        ),
      ],
    );

}

