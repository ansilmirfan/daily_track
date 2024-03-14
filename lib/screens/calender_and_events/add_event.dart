// ignore_for_file: camel_case_types, duplicate_ignore
import 'dart:io';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/db_functions/db_functions_events.dart';
import 'package:diary_app/model/Events.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types, must_be_immutable
class AddEvent extends StatefulWidget {
  DateTime selectedDay;
  bool edit;
  Events? value;

  AddEvent(
      {super.key, required this.selectedDay, this.value, this.edit = false});

  @override
  State<AddEvent> createState() => _AddEventState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionControllerr = TextEditingController();
TextEditingController locationController = TextEditingController();
File? _image;
String? imagepath;
bool reminder = false;
late DateTime selectedTime;

class _AddEventState extends State<AddEvent> {
  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: paddingS,
        color: primaryWhite,
        child: Wrap(
          runSpacing: 15,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add event',
                  style: TextStyle(fontSize: 25),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Text(
              DateFormat(
                'dd MMM yyyy ',
              ).format(widget.selectedDay),
            ),
            inputField(
              controller: titleController,
              hinttext: 'Enter event name',
              labeltext: 'Event name',
              validation: (value) {
                if (value == null) {
                  return 'Event Name Required ';
                } else {
                  return null;
                }
              },
            ),
            inputField(
              controller: descriptionControllerr,
              hinttext: 'enter description',
              labeltext: 'Description',
            ),
            inputField(
              controller: locationController,
              hinttext: 'Enter location',
              labeltext: 'Location',
            ),
            Text(
              'Add image',
              style: robotoL,
            ),
            IconButton(
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
            ),
            Visibility(
              visible: imagepath != null,
              child: SizedBox(
                width: width / 2,
                height: width / 2,
                child: imagepath == null
                    ? null
                    : Image.file(
                        File(imagepath!),
                      ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Reminder',
                  style: robotoL,
                ),
                Switch.adaptive(
                  value: reminder,
                  onChanged: (value) {
                    setState(() {
                      reminder = value;
                    });
                  },
                ),
              ],
            ),
            Visibility(
              visible: reminder,
              child: TimePickerSpinner(
                itemHeight: 40,
                time: DateTime.now(),
                is24HourMode: false,
                onTimeChange: (p0) {
                  selectedTime = p0;
                },
                normalTextStyle: TextStyle(fontSize: 25, color: grey),
                spacing: 20,
              ),
            ),
            textButtonWidget(
              function: () {
                if (titleController.text.isNotEmpty) {
                  var data = Events(
                      date: widget.selectedDay,
                      title: titleController.text,
                      notification: reminder,
                      description: descriptionControllerr.text,
                      // ignore: prefer_null_aware_operators
                      imagepath: _image == null ? null : imagepath,
                      location: locationController.text,
                      reminderTime: selectedTime);

                  var id = widget.value?.id;
                  widget.edit
                      ? editEvents(
                          id!,
                          Events(
                            date: widget.selectedDay,
                            title: titleController.text,
                            notification: reminder,
                            description: descriptionControllerr.text,
                            // ignore: prefer_null_aware_operators
                            imagepath: _image == null ? null : imagepath,
                            location: locationController.text,
                            reminderTime: selectedTime,
                            id: id,
                          ),
                        )
                      : addEvents(data, widget.selectedDay);
                }
                Navigator.of(context).pop();
              },
              width: width,
              text: 'Add',
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(
        () {
          _image = File(pickedFile.path);
          imagepath = _image!.path;
        },
      );
    }
  }

  void updateData() {
    if (widget.edit) {
      setState(() {
        imagepath = widget.value?.imagepath;
        titleController.text = widget.value!.title;
        descriptionControllerr.text = widget.value?.description ?? '';
        locationController.text = widget.value?.location ?? '';
        selectedTime = widget.selectedDay;
        reminder = widget.value!.notification;
        selectedTime = widget.value?.reminderTime ?? widget.value!.date;
      });
    } else {
      setState(() {
        _image = null;
        imagepath = null;
        reminder = false;
        titleController.clear();
        descriptionControllerr.clear();
        locationController.clear();
        selectedTime = widget.selectedDay;
      });
    }
  }
}
