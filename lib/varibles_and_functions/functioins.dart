// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/model/planner.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

//date and time picker
Future<DateTime?> initialiseDate(BuildContext context) async {
  DateTime? pickdatetime = await showOmniDateTimePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
    lastDate: DateTime.now().add(
      const Duration(days: 3652),
    ),
    is24HourMode: false,
    isShowSeconds: false,
    minutesInterval: 1,
    secondsInterval: 1,
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    constraints: const BoxConstraints(
      maxWidth: 350,
      maxHeight: 650,
    ),
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1.drive(
          Tween(
            begin: 0,
            end: 1,
          ),
        ),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    selectableDayPredicate: (dateTime) {
      if (dateTime == DateTime(2023, 2, 25)) {
        return false;
      } else {
        return true;
      }
    },
  );
  return pickdatetime;
}

//navigate push
navigatePush(BuildContext context, Widget page) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

//navigate push replacement
navigatePushReplacement(
  BuildContext context,
  Widget page,
) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

//delete alert

void deleteAlert(BuildContext context, void Function() delete,
    {bool fromdiaryView = false}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Delete'),
      content: Text(
        'Delete 1 item?',
        style: robotoM,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            delete();
            Navigator.of(context).pop();
            if (fromdiaryView) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Delete'),
        ),
      ],
    ),
  );
}

//category color
Color categoryColor(String data) {
  late Color color;
  switch (data) {
    case 'Work':
      color = const Color.fromARGB(255, 8, 121, 213);
      break;
    case 'Personal':
      color = primaryRed;
      break;
    case 'Hobby':
      color = primaryYellow;
      break;
    case 'Lifestyle':
      color = const Color.fromARGB(255, 39, 55, 160);
      break;
    case 'Other':
      color = Colors.grey;
      break;
    default:
      color = Colors.grey;
  }
  return color;
}

int totalCount(String category, List<Planner> data) {
  int count = 0;
  switch (category) {
    case 'All':
      count = data.length;

    case 'Work':
      count =
          data.where((element) => element.category == category).toList().length;

    case 'Personal':
      count =
          data.where((element) => element.category == category).toList().length;

    case 'Hobby':
      count =
          data.where((element) => element.category == category).toList().length;

    case 'Lifestyle':
      count =
          data.where((element) => element.category == category).toList().length;

    case 'Other':
      count =
          data.where((element) => element.category == category).toList().length;
    default:
      count = 0;
  }
  if (data == null) {
    count == 0;
  }
  return count;
}

int doneCount(String category, List<Planner> data) {
  int count = 0;
  switch (category) {
    case 'All':
      count =
          data.where((element) => element.doneOrNot == true).toList().length;

    case 'Work':
      count = data
          .where((element) => element.category == category)
          .toList()
          .where((element) => element.doneOrNot == true)
          .toList()
          .length;

    case 'Personal':
      count = data
          .where((element) => element.category == category)
          .toList()
          .where((element) => element.doneOrNot == true)
          .toList()
          .length;

    case 'Hobby':
      count = data
          .where((element) => element.category == category)
          .toList()
          .where((element) => element.doneOrNot == true)
          .toList()
          .length;

    case 'Lifestyle':
      count = data
          .where((element) => element.category == category)
          .toList()
          .where((element) => element.doneOrNot == true)
          .toList()
          .length;

    case 'Other':
      count = data
          .where((element) => element.category == category)
          .toList()
          .where((element) => element.doneOrNot == true)
          .toList()
          .length;
    default:
      count = 0;
  }
  if (data == null) {
    count == 0;
  }
  return count;
}
