// ignore_for_file: must_be_immutable

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/db_functions/db_functions_planner.dart';
import 'package:diary_app/model/planner.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget plannerList({required Planner planner}) {
  return ExpansionTile(
    collapsedShape: listTileBorder,
    leading: Checkbox(
      activeColor: Colors.transparent,
      side: const BorderSide(),
      checkColor: primaryBlack,
      value: planner.doneOrNot,
      onChanged: (value) {
        planner.doneOrNot = value!;
        editPlanner(planner);
      },
    ),
    shape: const OutlineInputBorder(
      borderRadius: borderradiusS,
    ),
    title: Text(
      planner.title,
      style: planner.doneOrNot
          ? const TextStyle(decoration: TextDecoration.lineThrough)
          : null,
    ),
    subtitle: Text(
      planner.description,
      style: planner.doneOrNot
          ? const TextStyle(decoration: TextDecoration.lineThrough)
          : null,
    ),
    trailing: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Wrap(
          children: [
            CircleAvatar(
              backgroundColor: categoryColor(planner.category),
              radius: 6,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(planner.category)
          ],
        ),
        Text(DateFormat('dd MMM yyyy').format(planner.date)),
      ],
    ),
  );
}
