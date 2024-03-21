// ignore_for_file: camel_case_types, must_be_immutable

import 'dart:io';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/intro_screens/create_password.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:diary_app/widgets/common/scaffold_messenger.dart';
import 'package:diary_app/widgets/common/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserDetails extends StatefulWidget {
  bool alreadyloggedin;
  // ignore: use_key_in_widget_constructors
  UserDetails({this.alreadyloggedin = false});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

Color circleAvatharBorder = primaryBlack;
File? image;
TextEditingController controller = TextEditingController();

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: primaryCream,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: height / 2,
                width: (width / 5 + 3) * 2,
                decoration: const BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                ),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: width / 5 + 3,
                      backgroundColor: circleAvatharBorder,
                      child: image == null
                          ? CircleAvatar(
                              radius: width / 5,
                              backgroundColor: primaryCream,
                              child: Icon(
                                Icons.person,
                                size: width / 5,
                                color: primaryBlack,
                              ),
                            )
                          : CircleAvatar(
                              radius: width / 5,
                              backgroundImage: FileImage(image!),
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                          circleAvatharBorder = primaryWhite;
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          color: primaryBlack,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height / 20,
              ),
              Form(
                key: key,
                child: inputField(
                    controller: controller,
                    borderwidth: 2.0,
                    hintcolor: Colors.grey,
                    hinttext: 'Enter user name',
                    horizontal_padding: width / 15,
                    labeltext: 'User name',
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter user name';
                      } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                        return 'Username can only contain letters and numbers';
                      } else if (value.length < 5) {
                        return 'Username must be at least 5 characters';
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                height: height / 30,
              ),
              textButtonWidget(
                text: 'Create',
                width: width * 7 / 8,
                function: () {
                  if (image == null) {
                    setState(() {
                      circleAvatharBorder =
                          const Color.fromARGB(255, 206, 50, 39);
                    });
                    snackbarMessage(
                        context, 'Please upload a profile picture', 'warning');
                  }
                  if (key.currentState!.validate() && image != null) {
                    userName = controller.text;
                    profilepicture = image?.path;
                    settingsDb.put('username', '$userName');
                    settingsDb.put('profilepicture', profilepicture);
                    if (widget.alreadyloggedin) {
                      Navigator.of(context).pop('returnded');
                    } else {
                      navigatePushReplacement(context, CreatePassword());
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(
        () {
          image = File(pickedFile.path);
        },
      );
    }
  }
}
