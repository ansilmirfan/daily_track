// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:ui';
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/color_and_fonts/fonts.dart';
import 'package:diary_app/screens/settings/settings.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:diary_app/widgets/common/inputfield.dart';
import 'package:flutter/material.dart';

class SilvarBar extends StatefulWidget {
  bool searchbar;
  TextEditingController? controller;
  void Function()? controllerClear;
  Function(String)? onChanged;
  bool settingsInAction;
  FocusNode? focus;
  SilvarBar({
    super.key,
    this.searchbar = true,
    this.controller,
    this.controllerClear,
    this.onChanged,
    this.settingsInAction = false,
    this.focus,
  });

  @override
  State<SilvarBar> createState() => _SilvarBarState();
}

bool isExpanded = false;

class _SilvarBarState extends State<SilvarBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryRed,
      expandedHeight: height / 3,
      pinned: true,
      floating: true,
      title: Text(
        '$userName',
        style: fonts[11](20.0, primaryBlack),
      ),
      actions: [
        Visibility(
          visible: widget.settingsInAction,
          child: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              )
                  .then((value) {
                if (value.isNotEmpty) {
                  setState(() {
                    profilepicture;
                    userName;
                  });
                }
              });
            },
            icon: const Icon(
              Icons.settings,
              color: primaryBlack,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          isExpanded = constraints.maxHeight > (height / 3 - 100);
          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(0),
            title: isExpanded
                ? Padding(
                    padding: paddingS,
                    child: Visibility(
                      visible: widget.searchbar,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 4),
                            child: inputField(
                              labeltext: 'Search',
                              labelcolor: primaryBlack,
                              field_textcolor: primaryBlack,
                              controller:
                                  widget.controller ?? TextEditingController(),
                              hinttext: 'Search...',
                              hintcolor: primaryBlack,
                              leading: const Icon(Icons.search),
                              trailing: IconButton(
                                onPressed: widget.controllerClear,
                                icon: const Icon(
                                  Icons.close,
                                  color: primaryBlack,
                                ),
                              ),
                              onChanged: widget.onChanged,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
            expandedTitleScale: 1,
            background: Opacity(
              opacity: 1.0,
              child: Image(
                image: FileImage(
                  File(profilepicture!),
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
