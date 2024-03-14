// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:diary_app/model/Diary.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<Diary>> diaryNotifier = ValueNotifier([]);

Future<void> addDiary(Diary value) async {
  final diaryDb = await Hive.openBox<Diary>('diarydb');
  value.id = await diaryDb.add(value);
  diaryDb.put(value.id, value);
  diaryNotifier.value.add(value);
  diaryNotifier.notifyListeners();
}

Future<void> updateDiaryValues() async {
  final diaryDb = await Hive.openBox<Diary>('diarydb');
  diaryNotifier.value.clear();
  diaryNotifier.value.addAll(diaryDb.values);
  diaryNotifier.notifyListeners();
}

Future<void> deleteDiary(int id) async {
  final diaryDb = await Hive.openBox<Diary>('diarydb');
  await diaryDb.delete(id);
  updateDiaryValues();
}

Future<void> editDiary(Diary value) async {
  final diaryDb = await Hive.openBox<Diary>('diarydb');
  await diaryDb.put(value.id, value);
  updateDiaryValues();
}

searchDiary(String value) async {
  final diaryDb = await Hive.openBox<Diary>('diarydb');
  diaryNotifier.value = diaryDb.values
      .where((element) => element.title.toLowerCase().contains(value))
      .toList();
}
