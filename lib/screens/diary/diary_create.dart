import 'dart:io';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/db_functions/db_functions_diary.dart';
import 'package:diary_app/model/Diary.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/bottom_sheet.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:diary_app/widgets/diary/bottom_sheet_color.dart';
import 'package:diary_app/widgets/diary/draggable_scrollable_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class DiaryCreate extends StatefulWidget {
  const DiaryCreate({super.key});

  @override
  State<DiaryCreate> createState() => _DiaryCreateState();
}

// ignore: camel_case_types
class _DiaryCreateState extends State<DiaryCreate> {
  File? _image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  DateTime? _dateTime;
  late int _bgColorSelected;
  late int _textColorSelected;
  late int _textStyleSelected;
  final _undoController = UndoHistoryController();

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _titleController.clear();
    _contentController.clear();
    _bgColorSelected = 0;
    _textColorSelected = 3;
    _textStyleSelected = 0;
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    bool canUndo = _undoController.value.canUndo;
    bool canRedo = _undoController.value.canRedo;
    _undoController.addListener(() {
      setState(() {
        canUndo = _undoController.value.canUndo;
        canRedo = _undoController.value.canRedo;
      });
    });
    bool keyboad = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor:
              _image == null ? primaryWhite : bgColors[_textColorSelected],
          title: Wrap(
            children: [
              IconButton(
                onPressed: canUndo ? () => _undoController.undo() : null,
                icon: const Icon(Icons.undo_outlined),
              ),
              IconButton(
                onPressed: canRedo ? () => _undoController.redo() : null,
                icon: const Icon(Icons.redo),
              )
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => selectImage(),
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
                image: _image == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          _image!,
                        ),
                      ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: width / 2 - 10,
                          //title
                          child: TextField(
                            controller: _titleController,
                            style: fonts[_textStyleSelected](
                                25.0, bgColors[_textColorSelected]),
                            decoration: const InputDecoration(
                                hintText: 'Title',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      //date
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () async {
                            _dateTime =
                                await initialiseDate(context) ?? DateTime.now();
                            setState(() {
                              _dateTime;
                            });
                          },
                          child: Text(
                            DateFormat('dd MMM yyyy hh:mm a')
                                .format(_dateTime ?? DateTime.now()),
                            style: fonts[_textStyleSelected](
                                15.0,
                                _textColorSelected == 3
                                    ? primaryWhite
                                    : bgColors[_textColorSelected]),
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
                color: bgColors[_bgColorSelected],
                child: Padding(
                  padding: paddingXS,
                  child: TextField(
                    controller: _contentController,
                    undoController: _undoController,
                    maxLines: 20,
                    style: fonts[_textStyleSelected](
                        18.0, bgColors[_textColorSelected]),
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
                                  context: context,
                                  OnTap: updateSlectedFontColor),
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
                                  context: context,
                                  OnTap: updateSelectedBgColor),
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
      _bgColorSelected = index;
    });
  }

  void updateSlectedFontColor(int index) {
    setState(() {
      _textColorSelected = index;
    });
  }

  void updateSelectedFont(int index) {
    setState(() {
      _textStyleSelected = index;
    });
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void validate() {
    if (_image == null) {
      snackbarMessage(
          context,
          'Error: Image is required. Please upload or select an image to proceed',
          'error');
    } else if (_titleController.text.isEmpty) {
      snackbarMessage(
          context, 'Error:Title is required.Please enter title', 'error');
    } else if (_contentController.text.isEmpty) {
      snackbarMessage(
          context, 'Error:Content is required.Please enter content', 'error');
    } else {
      final value = Diary(
        title: _titleController.text.trim(),
        content: _contentController.text,
        dateTime: _dateTime!,
        font: _textStyleSelected,
        fontcolor: _textColorSelected,
        bgcolor: _bgColorSelected,
        imgpath: _image!.path,
      );
      addDiary(value);

      Navigator.of(context).pop();
    }
  }

  void selectImage() {
    showBottomsheet(
      context: context,
      height: 60,
      content: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          IconButton.outlined(
            tooltip: 'Camera',
            onPressed: () {
              pickImage(ImageSource.camera);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.camera_alt,
            ),
          ),
          IconButton.outlined(
            tooltip: 'Gallery',
            onPressed: () {
              pickImage(ImageSource.gallery);
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.image,
            ),
          )
        ],
      ),
    );
  }
}
