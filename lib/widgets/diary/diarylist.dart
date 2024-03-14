import 'dart:io';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/db_functions/db_functions_diary.dart';
import 'package:diary_app/model/Diary.dart';
import 'package:diary_app/screens/diary/detailed_diary.dart';
import 'package:diary_app/screens/diary/edit_diary.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/slidable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget diaryList({required BuildContext context, required Diary diary}) {
  return GestureDetector(
    onTap: () {
      navigatePush(context, DetailedDiary(value: diary));
    },
    child: slidableWidget(
      delete: () => deleteAlert(
        context,
        () {
          deleteDiary(diary.id!);
        },
      ),
      edit: () => navigatePush(
        context,
        DiaryEdit(value: diary, navigateHome: true),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: height / 6,
            width: width * 9 / 10,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: primaryBlack,
                    borderRadius: borderradiusS,
                  ),
                  height: height / 6,
                  width: width * 2 / 10 - 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        DateFormat('dd').format(diary.dateTime),
                        style:
                            const TextStyle(color: primaryWhite, fontSize: 25),
                      ),
                      Text(
                        DateFormat('MMM').format(diary.dateTime),
                        style:
                            const TextStyle(color: primaryWhite, fontSize: 20),
                      ),
                      Text(
                        '${diary.dateTime.year}',
                        style:
                            const TextStyle(color: primaryWhite, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      height: height / 6 - 10,
                      width: height / 6 - 10,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: primaryBlack,
                              blurRadius: 1,
                              blurStyle: BlurStyle.outer)
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(diary.imgpath),
                          ),
                        ),
                        borderRadius: borderradiusS,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    width: width * 3 / 10,
                    height: height / 9,
                    decoration: BoxDecoration(
                      color: bgColors[diary.bgcolor],
                      boxShadow: const [
                        BoxShadow(
                            color: primaryBlack,
                            spreadRadius: 0.5,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 1.0)
                      ],
                      borderRadius: borderradiusS,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          diary.title,
                          style: fonts[diary.font](
                              15.0, bgColors[diary.fontcolor]),
                        ),
                        Text(
                          DateFormat('hh:mm a').format(diary.dateTime),
                          style: fonts[diary.font](
                              11.0, bgColors[diary.fontcolor]),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
