// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:hive_flutter/adapters.dart';
part 'Diary.g.dart';

@HiveType(typeId: 10)
class Diary {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime dateTime;
  @HiveField(4)
  int font;
  @HiveField(5)
  int fontcolor;
  @HiveField(6)
  int bgcolor;
  @HiveField(7)
  String imgpath;
  Diary(
      {required this.title,
      required this.content,
      required this.dateTime,
      required this.font,
      required this.fontcolor,
      required this.bgcolor,
      required this.imgpath,
      this.id});
}
