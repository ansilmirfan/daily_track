import 'dart:io';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/db_functions/db_functions_diary.dart';
import 'package:diary_app/model/Diary.dart';
import 'package:diary_app/screens/diary/edit_diary.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable, camel_case_types
class DetailedDiary extends StatefulWidget {
  Diary value;
  DetailedDiary({super.key, required this.value});

  @override
  State<DetailedDiary> createState() => _DetailedDiaryState();
}

DateTime? dateTime;
late int bgColorSelected;
late int textColorSelected;
late int textStyleSelected;
late String titile;
late String content;
late String imagePath;

// ignore: camel_case_types
class _DetailedDiaryState extends State<DetailedDiary> {
  @override
  void initState() {
    super.initState();
    dateTime = widget.value.dateTime;
    bgColorSelected = widget.value.bgcolor;
    textColorSelected = widget.value.fontcolor;
    textStyleSelected = widget.value.font;
    titile = widget.value.title;
    content = widget.value.content;
    imagePath = widget.value.imgpath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 1 / 3,
            width: width,
            decoration: BoxDecoration(
              color: secondaryBlack,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(imagePath),
                ),
              ),
            ),
            child: SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: bgColors[textColorSelected],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.value.title,
                          style: fonts[textStyleSelected](
                              28.0, bgColors[textColorSelected]),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          DateFormat('dd MMM yyyy hh:mm a').format(dateTime!),
                          style: fonts[textStyleSelected](
                              18.0, bgColors[textColorSelected]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
          SingleChildScrollView(
            child: Container(
              height: height * 2 / 3,
              padding: paddingS,
              decoration: BoxDecoration(
                color: bgColors[bgColorSelected],
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Text(
                    widget.value.content,
                    style: fonts[textStyleSelected](
                        18.0, bgColors[textColorSelected]),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(50),
        child: SizedBox(
          width: width * 7 / 10,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: primaryYellow, borderRadius: borderradiusS),
                child: IconButton(
                  onPressed: () {
                    deleteAlert(context, () {
                      deleteDiary(widget.value.id!);
                    }, fromdiaryView: true);
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: primaryYellow, borderRadius: borderradiusS),
                child: IconButton(
                  onPressed: () async {
                    final Diary? data = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DiaryEdit(
                          value: Diary(
                            title: titile,
                            content: content,
                            dateTime: dateTime!,
                            font: textStyleSelected,
                            fontcolor: textColorSelected,
                            bgcolor: bgColorSelected,
                            imgpath: imagePath,
                            id: widget.value.id,
                          ),
                        ),
                      ),
                    );
                    if (data != null) {
                      setState(() {
                        dateTime = data.dateTime;
                        bgColorSelected = data.bgcolor;
                        textColorSelected = data.fontcolor;
                        textStyleSelected = data.font;
                        titile = data.title;
                        content = data.content;
                        imagePath = data.imgpath;
                      });
                    }
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
