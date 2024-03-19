// ignore_for_file: prefer_const_constructors_in_immutables, camel_case_types, must_be_immutable

import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/db_functions/db_functions_planner.dart';
import 'package:diary_app/model/planner.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:diary_app/widgets/common/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePlanner extends StatefulWidget {
  BuildContext context;
  bool edit;
  Planner? planner;
  CreatePlanner(
      {super.key, required this.context, this.edit = false, this.planner});
  @override
  State<CreatePlanner> createState() => _CreatePlannerState();
}

DateTime? date = DateTime.now();
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
String category = 'Other';

class _CreatePlannerState extends State<CreatePlanner> {
  @override
  void initState() {
    super.initState();
    if (widget.edit) {
      date = widget.planner?.date;
      titleController.text = widget.planner!.title;
      category = widget.planner!.category;
    } else {
      titleController.clear();
      category = 'Other';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingS,
      color: primaryWhite,
      child: Wrap(
        runSpacing: 20,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  date = await initialiseDate(widget.context);
                  setState(
                    () {
                      date;
                    },
                  );
                },
                child: Text(
                  DateFormat('dd MMM yyyy hh:mm a').format(
                    date ?? DateTime.now(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              )
            ],
          ),
          inputField(
            controller: titleController,
            labeltext: null,
            hinttext: 'Enter title',
          ),
          inputField(
              controller: descriptionController, hinttext: 'Enter description'),
          Center(
            child: DropdownButton<String>(
              value: category,
              items: const [
                DropdownMenuItem(
                  value: 'Work',
                  child: Text('Work'),
                ),
                DropdownMenuItem(
                  value: 'Personal',
                  child: Text('Personal'),
                ),
                DropdownMenuItem(
                  value: 'Hobby',
                  child: Text('Hobby'),
                ),
                DropdownMenuItem(
                  value: 'Lifestyle',
                  child: Text('Lifestyle'),
                ),
                DropdownMenuItem(
                  value: 'Other',
                  child: Text('Other'),
                ),
              ],
              onChanged: (value) {
                setState(
                  () {
                    category = value!;
                  },
                );
              },
            ),
          ),
          textButtonWidget(
            function: () {
              if (titleController.text.length < 5) {
                snackbarMessage(
                    context, 'Please enter at least five charecter title');
              } else if (descriptionController.text.length < 5) {
                snackbarMessage(context,
                    'please enter at least five charecter description');
              } else {
                if (widget.edit) {
                  final data = Planner(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    doneOrNot: widget.planner!.doneOrNot,
                    category: category,
                    date: date!,
                    id: widget.planner!.id,
                  );
                  editPlanner(data);
                } else {
                  final data = Planner(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                    doneOrNot: false,
                    category: category,
                    date: date!,
                  );
                  addPlanner(data);
                }

                Navigator.of(context).pop();
              }
            },
            text: widget.edit ? 'Save' : 'Add',
            width: width,
          )
        ],
      ),
    );
  }
}
