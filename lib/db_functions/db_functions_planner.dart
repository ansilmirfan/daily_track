// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:diary_app/model/planner.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<Planner>> plannerNotifier = ValueNotifier([]);
//adding values
Future<void> addPlanner(Planner value) async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  value.id = await plannerdb.add(value);
  plannerdb.put(value.id, value);
  plannerNotifier.value.add(value);
  plannerNotifier.notifyListeners();
}

//upadating values
Future<void> updatePlanner() async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  plannerNotifier.value.clear();
  plannerNotifier.value.addAll(plannerdb.values);
  plannerNotifier.notifyListeners();
}

//edit
Future<void> editPlanner(Planner data) async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  plannerdb.put(data.id, data);
  updatePlanner();
}

//delete
Future<void> deletePlanner(int id) async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  plannerdb.delete(id);
  updatePlanner();
}

//searching
Future<void> searchplanner(String search) async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  plannerNotifier.value.clear();
  plannerNotifier.value.addAll(
    plannerdb.values.where(
      (element) => element.title.contains(search),
    ),
  );
  plannerNotifier.notifyListeners();
}

//sort by time
Future<void> sortByNamePlanner({bool asc = true}) async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  plannerNotifier.value.clear();
  plannerNotifier.value = List.from(plannerdb.values)
    ..sort(
      ((a, b) => a.title.compareTo(b.title)),
    );
  if (asc == false) {
    plannerNotifier.value = plannerNotifier.value.reversed.toList();
  }
  plannerNotifier.notifyListeners();
}

//sort by date
Future<void> sortbyDatePlanner({bool asc = true}) async {
  final plannerdb = await Hive.openBox<Planner>('plannerdb');
  plannerNotifier.value.clear();
  plannerNotifier.value = List.from(plannerdb.values)
    ..sort((a, b) => a.date.compareTo(b.date));
  if (asc == false) {
    plannerNotifier.value = plannerNotifier.value.reversed.toList();
  }
  plannerNotifier.notifyListeners();
}
