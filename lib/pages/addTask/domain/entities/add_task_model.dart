import 'package:hive_flutter/hive_flutter.dart';

import 'category.dart';

part 'add_task_model.g.dart';

@HiveType(typeId: 2)
class AddTaskModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String title;

  @HiveField(2)
  String time;

  @HiveField(3)
  TaskCategory category;

  @HiveField(4)
  String date;

  @HiveField(5)
  String id;
  @HiveField(6)
  String status;
  AddTaskModel(
      {required this.name,
      required this.title,
      required this.time,
      required this.category,
      required this.date,
      required this.id,
      this.status = "Default"});
}
