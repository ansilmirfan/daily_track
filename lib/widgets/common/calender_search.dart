import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:flutter/material.dart';

Widget calenderSearch({
  required BuildContext context,
  required void Function(DateTime?)? updateDate,
}) {
  return InkWell(
    splashColor: primaryRed,
    splashFactory: InkRipple.splashFactory,
    radius: 20.0,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1999),
        lastDate: DateTime(2050),
      );
      updateDate!(pickedDate);
    },
    child: const Icon(Icons.calendar_month_rounded),
  );
}
