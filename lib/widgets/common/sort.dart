// ignore_for_file: camel_case_types, sort_child_properties_last, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:diary_app/db_functions/db_functions_events.dart';
import 'package:diary_app/db_functions/db_functions_planner.dart';
import 'package:flutter/material.dart';
Widget sort({required bool event}){
  return PopupMenuButton<String>(
      position: PopupMenuPosition.under,
      child: const Icon(Icons.sort),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: const Text('By date(Newest first)'),
            onTap: () => event ? sortByDateEvent() : sortbyDatePlanner(),
          ),
          PopupMenuItem(
            child: const Text('By date(Oldest first)'),
            onTap: () => event
                ? sortByDateEvent(asc: false)
                : sortbyDatePlanner(asc: false),
          ),
          PopupMenuItem(
            child: const Text('Name A-Z'),
            onTap: () => event ? sortByTitleEvent() : sortByNamePlanner(),
          ),
          PopupMenuItem(
            child: const Text('Name Z-A'),
            onTap: () => event
                ? sortByTitleEvent(asc: false)
                : sortByNamePlanner(asc: false),
          ),
        ];
      },
    );
}


