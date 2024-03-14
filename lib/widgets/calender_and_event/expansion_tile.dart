// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names
import 'dart:io';

import 'package:diary_app/model/Events.dart';
import 'package:diary_app/screens/image_view.dart';
import 'package:diary_app/varibles_and_functions/functioins.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
Widget Expansiontile(BuildContext context,{required Events event, bool trailing=false,Function(bool)? onChanged}){
  return  ExpansionTile(
      shape: listTileBorder,
      collapsedShape: listTileBorder,
      title: Text(event.title),
      subtitle: Text(event.description ?? ''),
      trailing: trailing
          ? Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  DateFormat('dd MMM yyyy').format(event.date),
                ),
                const SizedBox(
                  width: 20,
                ),
                Switch.adaptive(
                  value: event.notification,
                  onChanged: onChanged,
                ),
              ],
            )
          : null,
      children: [
        Padding(
          padding: paddingXS,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (event.imagepath != null) {
                    navigatePush(
                        context, ImageView(imagepath: event.imagepath!));
                  }
                },
                child: Container(
                  width: width / 2 - 50,
                  height: height / 5,
                  decoration: BoxDecoration(
                    image: event.imagepath == null
                        ? const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('Assets/image/No photo.jpg'),
                          )
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              File(event.imagepath!),
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                width: width / 2 - 50,
                height: height / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy hh:mm a').format(event.date),
                    ),
                    Text(event.location ?? ''),
                    event.notification
                        ? Wrap(
                            children: [
                              const Icon(Icons.notifications_active_outlined),
                              Text(
                                DateFormat('hh:mm a')
                                    .format(event.reminderTime!),
                              ),
                            ],
                          )
                        : const Icon(Icons.notifications_none)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
}


