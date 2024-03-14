import 'package:hive/hive.dart';
part 'planner.g.dart';

@HiveType(typeId: 3)
class Planner extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  bool doneOrNot;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  String category;
  Planner({
    required this.title,
    required this.description,
    required this.doneOrNot,
    required this.category,
    required this.date,
    this.id,
  });
}
