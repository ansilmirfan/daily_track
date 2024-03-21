// ignore_for_file: camel_case_types, must_be_immutable

import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/diary/bottom_sheet_color.dart';
import 'package:diary_app/widgets/diary/draggable_scrollable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/db_functions/db_functions_diary.dart';
import 'package:diary_app/model/Diary.dart';
import 'package:diary_app/widgets/common/bottom_sheet.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiaryEdit extends StatefulWidget {
  Diary value;
  bool navigateHome;
  DiaryEdit({super.key, required this.value, this.navigateHome = false});

  @override
  State<DiaryEdit> createState() => _DiaryEditState();
}

File? _image;
TextEditingController titleController = TextEditingController();
TextEditingController contentController = TextEditingController();
DateTime? dateTime;
late String imagePath;
late int bgColorSelected;
late int textColorSelected;
late int textStyleSelected;
UndoHistoryController undoController = UndoHistoryController();

class _DiaryEditState extends State<DiaryEdit> {
  @override
  void initState() {
    super.initState();

    dateTime = widget.value.dateTime;
    titleController.text = widget.value.title;
    contentController.text = widget.value.content;
    bgColorSelected = widget.value.bgcolor;
    textColorSelected = widget.value.fontcolor;
    textStyleSelected = widget.value.font;
    imagePath = widget.value.imgpath;
  }

  @override
  Widget build(BuildContext context) {
    
    bool keyboad = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: bgColors[textColorSelected],
          title: Wrap(
            children: [
              IconButton(
                onPressed: () => undoController.undo(),
                icon: const Icon(Icons.undo_outlined),
              ),
              IconButton(
                onPressed: () => undoController.redo(),
                icon: const Icon(Icons.redo),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                showBottomsheet(
                  context: context,
                  height: 60,
                  content: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      IconButton.outlined(
                        tooltip: 'Camera',
                        onPressed: () {
                          _pickImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                        ),
                      ),
                      IconButton.outlined(
                        tooltip: 'Gallery',
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.image,
                        ),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.image),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        //body
        body: Column(
          children: [
            Container(
              width: width,
              height: height / 3,
              decoration: BoxDecoration(
                color: secondaryBlack,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(
                    File(imagePath),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: width - 20,
                        //title
                        child: TextField(
                          controller: titleController,
                          style: fonts[textStyleSelected](
                              28.0, bgColors[textColorSelected]),
                          decoration: const InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                        ),
                      ),
                      //date
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () async {
                            dateTime =
                                await initialiseDate(context) ?? DateTime.now();
                            setState(() {
                              dateTime;
                            });
                          },
                          child: Text(
                            DateFormat('dd MMM yyyy hh:mm a').format(dateTime!),
                            style: fonts[textStyleSelected](
                                15.0,
                                textColorSelected == 3
                                    ? primaryWhite
                                    : bgColors[textColorSelected]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //content
            Expanded(
              child: Container(
                color: bgColors[bgColorSelected],
                child: Padding(
                  padding: paddingXS,
                  child: TextField(
                    controller: contentController,
                    undoController: undoController,
                    maxLines: 20,
                    style: fonts[textStyleSelected](
                        18.0, bgColors[textColorSelected]),
                    decoration: const InputDecoration(
                        hintText: 'Content', border: InputBorder.none),
                  ),
                ),
              ),
            )
          ],
        ),
        //bottom sheet
        bottomSheet: Visibility(
          visible: !keyboad,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              width: width * 8 / 10,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: primaryYellow,
                      borderRadius: borderradiusS,
                    ),
                    child: Wrap(
                      children: [
                        //textstyle
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => draggableBottomSheet(
                                updateSelectedIndex: updateSelectedFont,
                              ),
                            );
                          },
                          icon: Image.asset(
                            'Assets/image/text icon.webp',
                            height: 40,
                            width: 40,
                          ),
                        ),
                        //text color
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => bottomSheetColor(
                                  OnTap: updateSelectedFont, context: context),
                            );
                          },
                          icon: const Icon(Icons.border_color_sharp),
                        ),
                        //bg color
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => bottomSheetColor(
                                OnTap: updateSelectedBgColor,
                                context: context,
                              ),
                            );
                          },
                          icon: const Icon(Icons.color_lens),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: primaryYellow,
                      borderRadius: borderradiusS,
                    ),
                    child: IconButton(
                      onPressed: validate,
                      icon: const Icon(Icons.done),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateSelectedBgColor(int index) {
    setState(() {
      bgColorSelected = index;
    });
  }

  void updateSlectedFontColor(int index) {
    setState(() {
      textColorSelected = index;
    });
  }

  void updateSelectedFont(int index) {
    setState(() {
      textStyleSelected = index;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        imagePath = _image!.path;
      });
    }
  }

  validate() {
    if (titleController.text.isEmpty) {
      snackbarMessage(
          context, 'Error:Title is required.Please enter title', 'error');
    } else if (contentController.text.isEmpty) {
      snackbarMessage(
          context, 'Error:Content is required.Please enter content', 'error');
    } else {
      final value = Diary(
          title: titleController.text.trim(),
          content: contentController.text,
          dateTime: dateTime!,
          font: textStyleSelected,
          fontcolor: textColorSelected,
          bgcolor: bgColorSelected,
          id: widget.value.id,
          imgpath: imagePath);
      editDiary(value);
      Navigator.of(context).pop(value);

      snackbarMessage(context, 'Diary edited successfully', 'success');
    }
  }
}
