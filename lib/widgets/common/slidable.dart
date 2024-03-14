// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget slidableWidget({required  Widget child,required   Function() edit,required Function() delete,BuildContext? context}){
  return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            edit();
          },
          icon: Icons.edit,
          backgroundColor: Colors.blue,
        )
      ]),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              delete();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
          )
        ],
      ),
      child: child,
    );
}


