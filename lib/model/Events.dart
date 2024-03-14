// ignore_for_file: file_names, duplicate_ignore

import 'package:hive/hive.dart';
part 'Events.g.dart';

@HiveType(typeId: 2)
class Events extends HiveObject{
  @HiveField(0)
  int? id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? location;
  @HiveField(5)
  String? imagepath;
  @HiveField(6)
  bool notification;
  @HiveField(7)
  DateTime? reminderTime;
  Events(
      {required this.date,
      required this.title,
      required this.notification,
      this.description,
      this.imagepath,
      this.location,
      this.id,
      this.reminderTime
      });
}
